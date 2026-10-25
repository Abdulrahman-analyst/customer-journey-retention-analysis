-- SQLite. Run after the notebook loads the cleaned events table.
-- Timestamps and window constants are in milliseconds.

CREATE INDEX IF NOT EXISTS idx_events_visitor_item_time
ON events (visitorid, itemid, timestamp);

-- Q1: Ordered funnel, one row per eligible visitor-item pair.
DROP TABLE IF EXISTS funnel_pairs;

CREATE TABLE funnel_pairs AS
WITH first_views AS (
    SELECT
        visitorid,
        itemid,
        MIN(timestamp) AS view_time
    FROM events
    WHERE event = 'view'
    GROUP BY visitorid, itemid
    HAVING MIN(timestamp) <= (
        SELECT MAX(timestamp) - 1209600000
        FROM events
    )
),
cart_matches AS (
    SELECT
        v.visitorid,
        v.itemid,
        v.view_time,
        c.timestamp AS cart_time,
        (
            SELECT MIN(p.timestamp)
            FROM events AS p
            WHERE p.visitorid = v.visitorid
              AND p.itemid = v.itemid
              AND p.event = 'transaction'
              AND p.timestamp > c.timestamp
              AND p.timestamp <= c.timestamp + 604800000
        ) AS purchase_time
    FROM first_views AS v
    LEFT JOIN events AS c
        ON c.visitorid = v.visitorid
       AND c.itemid = v.itemid
       AND c.event = 'addtocart'
       AND c.timestamp > v.view_time
       AND c.timestamp <= v.view_time + 604800000
)
SELECT
    visitorid,
    itemid,
    view_time,
    COALESCE(
        MIN(CASE WHEN purchase_time IS NOT NULL THEN cart_time END),
        MIN(cart_time)
    ) AS cart_time,
    MIN(purchase_time) AS purchase_time
FROM cart_matches
GROUP BY visitorid, itemid, view_time;

SELECT
        COUNT(*) AS viewed_pairs,
        COUNT(cart_time) AS cart_pairs,
        COUNT(purchase_time) AS purchased_pairs
    FROM funnel_pairs;

-- Q2: Complete eligible first-view weeks. Rates are fractions.
WITH weekly AS (
    SELECT
        date(view_time / 1000.0, 'unixepoch', '-6 days', 'weekday 1') AS week_start,
        COUNT(*) AS viewed_pairs,
        COUNT(cart_time) AS cart_pairs,
        COUNT(purchase_time) AS purchased_pairs
    FROM funnel_pairs
    GROUP BY week_start
), bounds AS (
    SELECT MIN(timestamp) AS first_event, MAX(timestamp) AS last_event
    FROM events
)
SELECT
    w.*,
    1.0 * cart_pairs / NULLIF(viewed_pairs, 0) AS view_to_cart,
    1.0 * purchased_pairs / NULLIF(cart_pairs, 0) AS cart_to_purchase
FROM weekly AS w
CROSS JOIN bounds AS b
WHERE CAST(strftime('%s', week_start) AS INTEGER) * 1000 >= first_event
  AND CAST(strftime('%s', week_start) AS INTEGER) * 1000 + 604800000
      <= last_event - 1209600000
ORDER BY week_start;
