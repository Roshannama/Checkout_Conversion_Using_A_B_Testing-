# Checkout Conversion & Revenue Optimization Using A/B Testing

## Project Overview

**Checkout Conversion & Revenue Optimization Using A/B Testing** is an end-to-end product analytics case study for an e-commerce company, ShopSmart.

The business problem is simple:

> ShopSmart redesigned its checkout experience to make purchasing easier. Before rolling out the new checkout to all users, the company wants to determine whether the redesign actually improves conversion and creates meaningful business value.

This project analyzes a synthetic but production-style event-level dataset using **PostgreSQL, SQL, Python, Pandas, NumPy, SciPy, and Statsmodels**.

The project focuses on one business problem rather than building a generic analytics platform.

---

## Business Problem

ShopSmart currently has an existing checkout flow:

```text
Homepage
   ↓
Search
   ↓
Product View
   ↓
Add to Cart
   ↓
Checkout
   ↓
Shipping
   ↓
Payment
   ↓
Order Confirmation
```

The company introduced a redesigned checkout:

```text
Homepage
   ↓
Search
   ↓
Product View
   ↓
Add to Cart
   ↓
Checkout
   ↓
Shipping
   ↓
One-Click Payment
   ↓
Order Confirmation
```

The redesigned checkout is expected to reduce friction and increase purchase completion.

The business question is:

> **Should ShopSmart roll out the redesigned checkout to all users?**

The decision is not based only on conversion rate. The analysis considers:

- Conversion
- Funnel drop-off
- Revenue
- Average Order Value
- Revenue per User
- Profit
- Segment-level performance
- Statistical significance
- Confidence intervals
- Effect size
- Statistical power
- Incremental business impact

---

# Objectives

The project aims to:

1. Compare Control and Treatment users.
2. Measure checkout conversion.
3. Analyze the complete purchase funnel.
4. Identify where users drop out.
5. Measure revenue and profitability.
6. Compare Treatment performance across customer segments.
7. Statistically test whether observed differences are meaningful.
8. Estimate the potential business impact of the redesign.
9. Produce a final data-driven rollout recommendation.

---

# Dataset

The project uses a synthetic event-level e-commerce dataset designed to resemble production data.

The data is generated using:

- Probability distributions
- Conditional probabilities
- Customer behavior patterns
- Product preferences
- Session behavior
- Purchase probabilities
- Experiment assignment

The data is intentionally designed to contain realistic relationships rather than independent random values.

## Dataset Size

Target dataset:

| Dataset | Approximate Size |
|---|---:|
| Users | 120,000 |
| Products | 500 |
| Experiment Assignments | 120,000 |
| Sessions | 600,000 |
| Events | 6M+ |
| Orders | ~35K–50K |

Actual row counts should be reported from the generated files rather than assumed.

---

# Data Model

The project contains six CSV datasets.

```text
users.csv
    │
    ├───────────────┐
    │               │
    ↓               ↓
experiment       sessions
assignment          │
                    ↓
                  events
                    │
                    ↓
                  orders
                    │
                    ↓
                products
```

## 1. users.csv

Contains customer-level information.

| Column | Description |
|---|---|
| user_id | Unique customer identifier |
| signup_date | Customer registration date |
| country | Customer country |
| city | Customer city |
| age | Customer age |
| gender | Customer gender |
| customer_type | New/returning customer classification |
| premium_member | Premium membership indicator |
| signup_channel | Customer acquisition channel |
| lifetime_value | Estimated customer lifetime value |
| preferred_device | Preferred device |

---

## 2. products.csv

Contains product catalog information.

| Column | Description |
|---|---|
| product_id | Unique product identifier |
| product_name | Product name |
| category | Product category |
| subcategory | Product subcategory |
| brand | Product brand |
| price | Product selling price |
| cost | Product cost |
| discount_percent | Product discount |
| rating | Product rating |
| stock_quantity | Available inventory |
| seller | Seller |
| launch_date | Product launch date |

Example categories:

- Electronics
- Fashion
- Home
- Beauty
- Sports
- Books
- Toys
- Groceries
- Pet Supplies
- Automotive

---

## 3. experiment_assignment.csv

Defines the A/B experiment assignment.

| Column | Description |
|---|---|
| assignment_id | Unique assignment identifier |
| user_id | Customer identifier |
| experiment_name | Experiment identifier |
| group | Control or Treatment |

Each user receives exactly one experiment assignment.

Target allocation:

```text
Control    ≈ 50%
Treatment  ≈ 50%
```

---

## 4. sessions.csv

Contains browsing/session-level behavior.

| Column | Description |
|---|---|
| session_id | Unique session identifier |
| user_id | Customer identifier |
| session_start | Session start timestamp |
| session_end | Session end timestamp |
| device | Mobile/Desktop/Tablet |
| browser | Browser |
| operating_system | Operating system |
| traffic_source | Acquisition source |
| landing_page | Initial page |
| country | Session country |
| city | Session city |
| is_returning | Returning-session indicator |
| session_duration | Session duration |
| pages_viewed | Pages viewed |
| bounce | Bounce-session indicator |

---

## 5. events.csv

Contains event-level behavioral data.

| Column | Description |
|---|---|
| event_id | Unique event identifier |
| session_id | Session identifier |
| event_name | User action |
| event_sequence | Position of event within session |
| event_time | Event timestamp |

Example events:

```text
Homepage
Search
Product_View
Add_to_Cart
Checkout
Shipping
Payment
One_Click_Payment
Purchase
```

Because events are linked to sessions, the user's identity can be recovered through:

```text
events → sessions → users
```

---

## 6. orders.csv

Contains transaction-level information.

| Column | Description |
|---|---|
| order_id | Unique order identifier |
| user_id | Customer identifier |
| session_id | Session that generated order |
| product_id | Purchased product |
| quantity | Quantity purchased |
| unit_price | Product price |
| discount | Applied discount |
| coupon_used | Coupon indicator |
| payment_method | Payment method |
| shipping_cost | Shipping cost |
| tax | Tax amount |
| total_amount | Final order amount |
| profit | Order profit |
| purchase_time | Purchase timestamp |
| order_status | Completed/Refunded/etc. |

---

# Technology Stack

## Database

- PostgreSQL

## SQL

- SELECT
- WHERE
- GROUP BY
- HAVING
- CASE
- CTEs
- JOINs
- Window functions
- Conditional aggregation
- Date functions
- Views
- Constraints
- Indexes

## Python

- Python
- Pandas
- NumPy

## Statistics

- SciPy
- Statsmodels

Statistical methods include:

- Two-proportion Z-test
- Chi-square test
- t-test
- Mann–Whitney U test
- Confidence intervals
- Effect size
- Power analysis
- Sample-size estimation
- Multiple-testing correction

---

# Project Workflow

```text
Business Problem
      ↓
Experiment Design
      ↓
Synthetic Data Generation
      ↓
PostgreSQL Database
      ↓
Data Validation
      ↓
SQL Business Analysis
      ↓
Python Data Cleaning
      ↓
EDA
      ↓
Metric Engineering
      ↓
A/B Testing
      ↓
Segmentation
      ↓
Business Impact Analysis
      ↓
Final Recommendation
```

---

# Phase 1 — Business Understanding

The primary hypothesis is:

### Null Hypothesis

The redesigned checkout has no effect on purchase conversion.

```text
H₀: p_treatment = p_control
```

### Alternative Hypothesis

The redesigned checkout improves purchase conversion.

```text
H₁: p_treatment > p_control
```

The primary business metric is:

```text
Conversion Rate =
Unique Purchasers / Experiment Users
```

---

# Phase 2 — Database Design

The CSV data is loaded into PostgreSQL.

Core tables:

```text
users
products
experiment_assignment
sessions
events
orders
```

Relationships:

```text
users.user_id
    ↓
experiment_assignment.user_id

users.user_id
    ↓
sessions.user_id

sessions.session_id
    ↓
events.session_id

users.user_id
    ↓
orders.user_id

products.product_id
    ↓
orders.product_id
```

Database features implemented:

- Primary keys
- Foreign keys
- NOT NULL constraints
- CHECK constraints
- Unique constraints
- Indexes
- Validation queries

---

# Phase 3 — Data Validation

Before analysis, validate:

### Structural Quality

- Primary key uniqueness
- Foreign key integrity
- Missing values
- Duplicate records
- Invalid timestamps
- Invalid numeric values
- Invalid categories

### Business Logic

Examples:

- Every order belongs to an existing user.
- Every order belongs to an existing session.
- Every event belongs to an existing session.
- Every purchased product exists.
- Every experiment user has one assignment.
- Order totals are mathematically consistent.
- Completed orders have valid revenue.

---

# Phase 4 — SQL Business Analysis

The SQL analysis answers business questions before statistical analysis.

## User Analysis

Calculate:

- Total users
- Active users
- Returning users
- Premium users
- Country distribution
- Device distribution

## Experiment Analysis

Calculate:

- Control users
- Treatment users
- Traffic split
- Sample Ratio Mismatch

## Funnel Analysis

Analyze:

```text
Homepage
    ↓
Search
    ↓
Product
    ↓
Add Cart
    ↓
Checkout
    ↓
Shipping
    ↓
Payment
    ↓
Purchase
```

For each stage calculate:

- Users
- Conversion
- Drop-off

## Revenue Analysis

Calculate:

- Total revenue
- Total profit
- Average Order Value
- Median order value
- Revenue per User
- Revenue by variant
- Revenue by device
- Revenue by country

## Segmentation

Analyze:

- Mobile vs Desktop
- Premium vs Regular
- Organic vs Paid
- Country
- Age group
- Returning vs New

---

# Phase 5 — Python Data Cleaning

Python is used after the initial SQL analysis.

Typical cleaning tasks:

- Parse timestamps
- Detect missing values
- Detect duplicates
- Validate numeric columns
- Identify outliers
- Standardize categories
- Validate event relationships
- Check impossible values

Example:

```python
events["event_time"] = pd.to_datetime(
    events["event_time"],
    errors="coerce"
)
```

---

# Phase 6 — Exploratory Data Analysis

EDA examines the behavior of customers and transactions.

## User Analysis

- Age distribution
- Gender distribution
- Country distribution
- Device distribution
- Premium membership

## Session Analysis

- Session duration
- Pages viewed
- Bounce rate
- Traffic source
- Returning sessions

## Revenue Analysis

- Revenue distribution
- Order value distribution
- Profit distribution
- Purchase frequency
- Quantity distribution

Visualizations include:

- Histograms
- Boxplots
- Bar charts
- Scatter plots
- Correlation analysis
- Funnel charts

---

# Phase 7 — Metric Engineering

The major product metrics are:

## Conversion Rate

```text
Purchasers / Experiment Users
```

## Absolute Conversion Uplift

```text
Treatment Conversion
-
Control Conversion
```

## Relative Conversion Uplift

```text
(Treatment - Control)
/
Control
× 100
```

## Average Order Value

```text
Total Revenue / Number of Orders
```

## Revenue Per User

```text
Total Revenue / Experiment Users
```

## Profit Per User

```text
Total Profit / Experiment Users
```

## Cart Abandonment

```text
1 - Purchasers / Cart Users
```

These metrics connect user behavior with financial outcomes.

---

# Phase 8 — A/B Testing

## Primary Test

For conversion, use a two-proportion test.

Control:

```text
p₁ = conversions_control / users_control
```

Treatment:

```text
p₂ = conversions_treatment / users_treatment
```

Observed difference:

```text
Δ = p₂ - p₁
```

The pooled proportion is:

```text
p_pool =
(x₁ + x₂) / (n₁ + n₂)
```

Standard error:

```text
SE =
sqrt(
p_pool(1-p_pool)
(1/n₁ + 1/n₂)
)
```

Z-statistic:

```text
Z = (p₂ - p₁) / SE
```

The p-value is then used to evaluate statistical evidence.

---

# Confidence Interval

A confidence interval quantifies uncertainty around the estimated difference.

Conceptually:

```text
Observed Effect ± Critical Value × Standard Error
```

For a 95% confidence interval:

```text
Critical value ≈ 1.96
```

The final report should state both:

- Estimated uplift
- Confidence interval

---

# Statistical Significance vs Business Significance

A statistically significant result does not automatically mean the business should launch the change.

Example:

```text
Conversion uplift = +0.1%
p-value < 0.05
```

This may be statistically significant with a very large sample but economically insignificant.

Therefore evaluate:

```text
Statistical significance
+
Effect size
+
Incremental revenue
+
Incremental profit
+
Implementation cost
```

---

# Phase 9 — Power Analysis

Before launching an experiment, determine whether the planned sample is large enough.

Inputs include:

- Baseline conversion
- Minimum Detectable Effect
- Significance level
- Statistical power

Typical values:

```text
Alpha = 0.05
Power = 0.80
```

The goal is to avoid:

- Underpowered experiments
- False conclusions
- Wasted engineering effort

---

# Phase 10 — Segmentation Analysis

Overall results can hide important differences.

Analyze treatment effects by:

- Device
- Country
- Traffic source
- Premium membership
- Age group
- Returning vs New

Example:

```text
Overall       +2%
Mobile        +7%
Desktop       +0.5%
```

This could indicate that the redesign particularly benefits mobile users.

However, segment results should be interpreted carefully because repeated testing increases false-positive risk and small segments may have unstable estimates.

---

# Phase 11 — Multiple Testing

Testing many segments increases the probability of finding an apparently significant result by chance.

Possible corrections:

### Bonferroni

Controls family-wise error rate.

```text
Adjusted alpha =
alpha / number of tests
```

### Benjamini–Hochberg

Controls the false discovery rate and is often less conservative than Bonferroni.

---

# Phase 12 — Business Impact Analysis

The final decision should translate statistical results into money.

Suppose:

```text
Daily users = N

Control conversion = p_control

Treatment conversion = p_treatment

Average order value = AOV
```

Estimated incremental purchases:

```text
Incremental Purchases =
N × (p_treatment - p_control)
```

Estimated incremental revenue:

```text
Incremental Revenue =
Incremental Purchases × AOV
```

For annual impact:

```text
Annual Incremental Revenue =
Daily Incremental Revenue × 365
```

If implementation cost exists:

```text
Incremental Profit =
Incremental Revenue × Profit Margin
-
Implementation Cost
```

The final recommendation should consider both statistical evidence and financial impact.

---

# Final Decision Framework

The checkout should be recommended for rollout only when the evidence supports the decision.

A strong recommendation considers:

### 1. Conversion

Did Treatment improve conversion?

### 2. Statistical evidence

Is the result statistically significant?

### 3. Confidence interval

Is the plausible range of the effect positive and sufficiently precise?

### 4. Business magnitude

Is the improvement large enough to matter?

### 5. Revenue

Does the treatment generate incremental revenue?

### 6. Profit

Does it improve profitability?

### 7. Segments

Are there important segments where performance worsens?

### 8. Experiment quality

Was randomization valid and was there evidence of SRM?

---

# Example Final Recommendation Structure

The final project conclusion should look like:

```text
Recommendation: [Roll Out / Do Not Roll Out / Run Longer Test]

Treatment conversion:
X.XX%

Control conversion:
X.XX%

Absolute uplift:
X.XX percentage points

Relative uplift:
X.XX%

p-value:
X.XXXX

95% CI:
[X.XX%, X.XX%]

Incremental annual revenue:
₹X

Incremental annual profit:
₹X

Key winning segments:
...

Key risks:
...

Next step:
...
```

Do not claim that Treatment is the winner until the statistical and business analyses have actually been completed.

---

# Project Folder Structure

```text
checkout-ab-testing/
│
├── data/
│   ├── raw/
│   │   ├── users.csv
│   │   ├── products.csv
│   │   ├── experiment_assignment.csv
│   │   ├── sessions.csv
│   │   ├── events.csv
│   │   └── orders.csv
│   │
│   └── processed/
│
├── database/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_constraints.sql
│   ├── 04_indexes.sql
│   ├── 05_import_data.sql
│   ├── 06_validation.sql
│   ├── 07_views.sql
│   └── 08_business_queries.sql
│
├── notebooks/
│   ├── 01_data_loading_cleaning.ipynb
│   ├── 02_eda.ipynb
│   ├── 03_metrics.ipynb
│   ├── 04_ab_testing.ipynb
│   ├── 05_segmentation.ipynb
│   └── 06_business_impact.ipynb
│
├── src/
│   ├── data_cleaning.py
│   ├── metrics.py
│   ├── ab_testing.py
│   ├── segmentation.py
│   └── business_impact.py
│
├── outputs/
│   ├── figures/
│   ├── statistical_results/
│   └── business_results/
│
├── requirements.txt
├── .gitignore
└── README.md
```

---

# Resume Version

### Checkout Conversion & Revenue Optimization Using A/B Testing

**PostgreSQL, SQL, Python, Pandas, SciPy, Statsmodels**

- Analyzed **120K users, 600K sessions, 6M+ events, and ~40K orders** to evaluate a redesigned e-commerce checkout's impact on conversion and revenue.
- Built **SQL-based funnel, revenue, and segmentation analysis** using CTEs, window functions, joins, and aggregations across device, country, traffic source, and customer type.
- Applied **A/B testing, two-proportion Z-tests, confidence intervals, effect sizes, and power analysis** to assess statistical and practical significance of checkout improvements.
- Quantified **conversion uplift, AOV, revenue per user, profit, and incremental revenue** to formulate a data-driven checkout rollout recommendation.

---

# Key Skills Demonstrated

## Data Analytics

- Data collection/generation
- Data cleaning
- Data validation
- EDA
- Metric engineering
- Business analysis

## SQL

- Complex joins
- CTEs
- Window functions
- Aggregation
- Conditional aggregation
- CASE statements
- Views
- Data validation

## Statistics

- Probability
- Hypothesis testing
- Two-proportion testing
- Confidence intervals
- Effect size
- Statistical power
- Sample-size calculation
- Multiple testing

## Business

- Product analytics
- Experimentation
- Funnel analysis
- Conversion optimization
- Revenue analysis
- Profitability
- Segmentation
- Incremental impact
- Decision making

---

# Core Business Question

The entire project ultimately answers one question:

> **Does the redesigned checkout create enough statistically credible and economically meaningful improvement to justify rolling it out to all ShopSmart users?**

The analysis should therefore move from:

```text
Raw Behavioral Data
        ↓
SQL
        ↓
Metrics
        ↓
Statistics
        ↓
Segmentation
        ↓
Financial Impact
        ↓
Business Recommendation
```

This makes the project an **analyst-focused product experimentation case study**, rather than simply a dashboard or data visualization project.

---

## Disclaimer

The dataset is synthetic and created for portfolio/learning purposes. Results should not be presented as actual ShopSmart business results. The methodology, SQL analysis, statistical framework, and business decision process are designed to demonstrate real-world analytical thinking.
