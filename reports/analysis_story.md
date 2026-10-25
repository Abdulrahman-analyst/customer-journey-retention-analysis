# 97.88% of Eligible Product Views Did Not Reach Cart

## Summary

Only **2.12%** of eligible visitor-product pairs reached cart within seven days of their first observed product view. That leaves **97.88%** outside the next funnel stage. Once a pair reached cart, **36.05%** reached purchase within the next seven days. Product discovery and the decision to add to cart are therefore the first areas to investigate.

First-day cart activity also distinguished visitors who returned: **15.03%** returned during days 1-7, compared with **5.63%** of visitors without a first-day cart event. The **9.40 percentage-point** difference is an association, not a measured effect of encouraging cart activity.

This analysis uses Retailrocket's anonymized ecommerce event file from May-September 2015. SQL constructs the ordered funnel; Python tracks cohorts and compares visitor-level proportions. It offers an investigation plan for this dataset, rather than a forecast for another retailer or market.

## Findings

### 1. The largest observed drop-off precedes cart entry

Of **1,938,845** eligible visitor-item pairs, **41,100** reached cart and **14,816** reached purchase. Step conversion was **2.12%** for view-to-cart and **36.05%** for cart-to-purchase; overall conversion was **0.76%**.

The unit is a unique visitor-item pair, not a person, session or order. A person viewing multiple products can contribute multiple pairs. The sequence requires a cart within seven days of first view and a purchase within seven days of that cart. All entry pairs have at least 14 days of observation available. A purchase outside this observed sequence does not count toward this particular funnel.

Low view-to-cart conversion alone cannot diagnose a broken product page. Browsing intent, traffic quality, product availability and event instrumentation are possible explanations that these fields cannot separate.

### 2. The same stage was weaker in every eligible full week

View-to-cart conversion was lower than cart-to-purchase in **all 17 complete entry weeks**, starting May 4 through August 24. The overall pattern therefore was not confined to one week.

The weekly chart uses the first-view week and excludes partial or insufficiently followed entry weeks. Its population differs slightly from the overall funnel, which retains eligible pairs from boundary weeks. Weekly consistency supports prioritizing investigation, but does not identify the cause of the gap.

### 3. Return activity falls quickly in the early weeks

For the cohort first observed in the week of May 4, about **4.8%** returned in week 1, **2.8%** in week 2 and **1.6%** in week 4. These rounded chart values describe activity in each separate week; they do not mean that every returning visitor stayed active continuously.

The April 27 cohort is a partial entry cohort containing observations from May 3 only. Its higher week-1 result should not be treated as a directly comparable acquisition cohort. Unfinished follow-up cells remain blank, rather than suggesting zero retention. First observed activity may also belong to an existing visitor whose earlier history is outside the file.

### 4. First-day cart visitors had a higher subsequent return rate

Group A had **4,623 returners among 30,761 visitors**, or **15.03%**. Group B had **74,108 among 1,315,712**, or **5.63%**. The difference was **+9.40 percentage points**, with a **95% Newcombe confidence interval of 9.00-9.80 points** and two-sided **p < 0.001**.

Each visitor belongs to one group and has a complete seven-calendar-day outcome window after the first day. The statistical result supports a difference between the observed groups under the test assumptions. Visitors who added early may already have stronger intent; this is not a randomized experiment and does not estimate the lift from a cart prompt or campaign.

## Recommendations

1. **Investigate view-to-cart before choosing a conversion intervention.** Review product-page behavior and tracking, then obtain availability, device and traffic-source data if possible. Test a specific change with a randomized holdout. Measure visitor-item cart conversion, with downstream purchase conversion as a guardrail. This follows the 97.88% drop-off and its consistency across 17 weeks.

2. **Test a first-week return intervention.** The early cohort decline makes the first week a useful test window. Where consent and contact permissions exist, randomize a relevant reminder against a holdout. Use days 1-7 visitor return as the primary outcome and purchase activity as a guardrail. No outcome lift is assumed in advance.

3. **Monitor first-day cart segments separately.** Track their sizes and later return rates alongside the non-cart group. Use the observed +9.40 pp gap as a segmentation signal when designing the return test, with randomization within segments. Do not use it as the promised impact of making more visitors add to cart.

## Scope

Source: [Retailrocket dataset on Kaggle](https://www.kaggle.com/datasets/retailrocket/ecommerce-dataset), listed as CC BY-NC-SA 4.0. Removed 460 exact duplicate rows under an explicit logging assumption. No abnormal-user filter was applied. Anonymous IDs, incomplete prehistory, possible tracking gaps and unmeasured visitor differences limit interpretation. These historical results do not establish current regional benchmarks.
