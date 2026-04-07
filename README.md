# 📊 Amazon Sales Performance Analysis Dashboard

---

## 🔍 Overview

This project presents an end-to-end data analytics workflow focused on analyzing Amazon sales data to uncover insights related to revenue trends, category performance, and regional distribution.

The analysis is visualized through an **interactive Power BI dashboard**, enabling users to explore business performance across time, product categories, and geographic regions.

---

## 🎯 Business Problem / Objective

The goal of this project is to answer key business questions such as:

* Which product categories generate the highest revenue?
* Which categories are growing the fastest?
* How does revenue trend over time?
* Which states contribute the most to overall sales?
* Are there emerging opportunities for expansion based on growth patterns?

---

## 📂 Data Source

* Dataset: Amazon Sales Dataset (Kaggle)
* Contains transactional data including:

  * Order details
  * Product categories
  * Sales amount
  * Customer location (state/city)
  * Order dates

> Note: The dataset was cleaned and preprocessed before analysis to ensure accuracy and usability.

---

## 🛠️ Tech Stack & Tools

* **Power BI** – Data visualization & dashboard creation
* **SQL** – Data querying and analytical calculations
* **Excel / CSV** – Initial data handling
* **DAX (Power BI)** – Measures for KPIs and growth calculations

---

## ⚙️ Methodology

### 1. Data Cleaning & Preparation

* Standardized date format (US format for SQL compatibility)
* Removed irrelevant columns:

  * `Unnamed: 22`, `fulfilled-by`, `ship-country`, `currency`
  * `Style`, `SKU`, `ASIN`, `ship-postal-code`, `promotion-ids`, `B2B`
* Handled missing values:

  * Replaced missing `Amount` with 0 (mostly cancelled orders)
* Removed duplicate records based on `Order ID` and `ASIN`
* Created additional fields:

  * Month and Month Number (for time-based analysis)
  * Ordered category for product sizes

---

### 2. Exploratory Data Analysis (EDA)

* Analyzed revenue distribution across categories
* Examined monthly revenue trends and MoM growth
* Evaluated geographic performance by state
* Compared category contribution and growth patterns

---

### 3. Feature Engineering

* Revenue contribution (%) calculation
* Month-over-Month (MoM) growth metrics
* Category-level overall growth comparison

---

### 4. Dashboard Development

* Designed an interactive Power BI dashboard with:

  * KPI cards (Revenue, Orders, AOV)
  * Category performance table (Revenue, Contribution %, Growth %)
  * Time-series trend analysis
  * State-wise revenue distribution
  * Insight summary for decision-making

---

## 📈 Key Insights & Results

* **Western Dress** is the fastest-growing category (~116%), indicating strong expansion potential.
* **Set category** contributes the highest share of total revenue, driving overall business performance.
* Revenue peaked in **April**, followed by a gradual decline, suggesting potential seasonality.
* **Maharashtra and Karnataka** are the top revenue-generating states, indicating regional concentration.

---

## 🗂️ Project Structure

```bash
Amazon-Sales-Analysis/
│
├── data/
│   └── amazon_sales.csv
│
├── dashboard/
│   └── amazon_dashboard.pbix
│
├── sql/
│   └── analysis_queries.sql
│
├── images/
│   └── dashboard_preview.png
│
└── README.md
```

---

## 🚀 How to Run

### Option 1: View Dashboard (Recommended)

* Open the live dashboard via Power BI Service:

```txt
[Add your Power BI link here]
```

---

### Option 2: Run Locally

1. Download the `.pbix` file
2. Open using **Power BI Desktop**
3. Refresh data if required

---

### Option 3: Run SQL Analysis

1. Import dataset into your SQL environment
2. Execute queries from:

```txt
## SQL Analysis

SQL was used to validate key metrics and perform aggregations such as:
- Revenue contribution by category
- Quarterly revenue trends
- Top-performing regions

See full queries in `sql_queries.sql`
```

---

## 🔮 Future Work

* Incorporate customer segmentation (B2B vs B2C analysis)
* Add profitability metrics (if cost data is available)
* Improve state-level growth analysis with better time granularity
* Automate data pipeline using Python/ETL tools
* Deploy dashboard within a portfolio website

---

## 💡 Key Takeaway

This project demonstrates the ability to:

* Clean and prepare real-world data
* Perform exploratory and analytical thinking
* Translate data into business insights
* Build interactive dashboards for decision-making

---

## 🔗 Live Dashboard

> 📊 Interactive dashboard available in PBIX file (download and open in Power BI Desktop)

---

## 👤 Author

**Sagar Sasmal**
Aspiring Data Analyst | SQL • Power BI • Data Visualization
