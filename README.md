# 👟 Adidas Sales Analytics

### *From Raw Sales Data to Actionable Business Insights*

> An end-to-end **Sales Analytics & Business Intelligence project**
> built around Adidas sales data. The project demonstrates the complete
> analytics lifecycle---from Excel data ingestion and Python
> preprocessing to PostgreSQL integration, interactive Power BI
> dashboards, forecasting, what-if scenario analysis, and business
> recommendations.

```{=html}
<p align="center">
```
![Python](https://img.shields.io/badge/Python-3.10+-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-150458?style=for-the-badge&logo=pandas)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Analysis-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Power
BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![EDA](https://img.shields.io/badge/EDA-Exploratory%20Analysis-success?style=for-the-badge)

```{=html}
</p>
```

------------------------------------------------------------------------

# 📌 Project Overview

The **Adidas Sales Analytics** project transforms raw transactional
sales data into an interactive business intelligence solution.

The objective is to understand:

-   Overall sales and profit performance
-   Year-over-year sales growth
-   Retailer contribution
-   Product category performance
-   Regional and city-level performance
-   Sales method performance
-   Pricing and profitability relationships
-   Future sales and profit expectations
-   The potential impact of price and volume changes

The final solution combines **Python, Pandas, PostgreSQL/SQL, and Power
BI** to create a complete analytics workflow.

------------------------------------------------------------------------

# 🏗 Project Architecture

``` text
                 Adidas Sales Dataset
                         │
                         ▼
                  Excel (.xlsx)
                         │
                         ▼
                Python / Pandas
                         │
             ┌───────────┴───────────┐
             │                       │
             ▼                       ▼
      Data Inspection          Feature Engineering
             │                       │
             └───────────┬───────────┘
                         ▼
                 Processed Dataset
                         │
                         ▼
                    PostgreSQL
                         │
                         ▼
                 Power BI Data Model
                         │
                         ▼
                  DAX Calculations
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
     KPI Analysis   Trend Analysis   Scenario Analysis
          │              │              │
          └──────────────┼──────────────┘
                         ▼
               Interactive Dashboard
                         │
                         ▼
             Business Insights & Actions
```

------------------------------------------------------------------------

# 📂 Dataset

The project uses the **Adidas Sales Data** Excel dataset.

### Dataset Size

  Attribute                         Value
  -------------------- ------------------
  Records                       **9,648**
  Original Columns                 **14**
  Date Range             **2020 -- 2021**
  Retailers                         **6**
  Product Categories                **3**
  Sales Methods                     **3**
  Regions                           **5**
  Cities                           **52**

### Original Columns

``` text
Retailer
Retailer ID
Invoice Date
Region
State
City
Gender Type
Product Category
Price per Unit
Units Sold
Total Sales
Operating Profit
Operating Margin
Sales Method
```

------------------------------------------------------------------------

# 🛠 Tech Stack

  Category                Tools
  ----------------------- ---------------------
  Programming             Python
  Data Analysis           Pandas
  Numerical Processing    NumPy
  Visualization / EDA     Matplotlib, Seaborn
  Database                PostgreSQL
  Query Language          SQL
  Business Intelligence   Power BI
  Calculations            DAX
  Source Data             Microsoft Excel
  Documentation           PDF / Report

------------------------------------------------------------------------

# 🚀 Project Workflow

## 📥 1. Data Loading

The Excel dataset is loaded into Python using Pandas.

``` python
import pandas as pd

df = pd.read_excel("./Adidas_Sales_Data.xlsx")
```

Initial inspection includes:

-   Dataset preview
-   Dataset dimensions
-   Data types
-   Descriptive statistics
-   Missing-value checks
-   Column inspection

------------------------------------------------------------------------

## 🔍 2. Exploratory Data Analysis

The preprocessing notebook performs initial data exploration using:

``` python
df.head()
df.info()
df.describe(include='all')
df.isnull().sum()
```

This helps understand:

-   Dataset structure
-   Data types
-   Numeric distributions
-   Missing values
-   Categorical fields
-   Overall data quality

### Data Quality Result

The source dataset contains:

-   **0 missing values**
-   **0 duplicate rows**

------------------------------------------------------------------------

## 🧹 3. Data Cleaning & Standardization

Column names were standardized to make them easier to work with in
Python and SQL.

``` python
df.columns = df.columns.str.lower()
df.columns = df.columns.str.replace(' ','_')
```

For example:

``` text
Invoice Date     → invoice_date
Total Sales      → total_sales
Operating Profit → operating_profit
Product Category → product_category
```

------------------------------------------------------------------------

# 📅 4. Feature Engineering

### Date Conversion

The invoice date was converted into a proper datetime field:

``` python
df['invoice_date'] = pd.to_datetime(df['invoice_date'])
```

### Date Features

The following analytical features were created:

``` text
year
month
day
day_of_week
day_name
week_of_year
quarter
is_weekend
```

These features support time-based analysis such as:

-   Monthly sales trends
-   Year comparisons
-   Quarterly performance
-   Weekday/weekend analysis
-   Time-based dashboard filtering

------------------------------------------------------------------------

# 💰 5. Revenue & Profit Features

Two additional business metrics were engineered.

### Profit Per Unit

``` python
df['profit_per_unit'] = (
    df['operating_profit'] / df['units_sold']
)
```

### Sales Per Unit

``` python
df['sales_per_unit'] = (
    df['total_sales'] / df['units_sold']
)
```

These metrics support the pricing and profitability analysis in Power
BI.

------------------------------------------------------------------------

# 🗄 6. PostgreSQL Integration

After preprocessing, the DataFrame is loaded into PostgreSQL.

The project uses:

-   SQLAlchemy
-   psycopg2
-   PostgreSQL

The processed data is stored in a database table and then used as the
analytical source for the BI layer.

``` text
Python / Pandas
       ↓
Processed DataFrame
       ↓
SQLAlchemy
       ↓
PostgreSQL
       ↓
Power BI
```

> **Security note:** Database passwords and local credentials are
> intentionally not included in this README.

------------------------------------------------------------------------

# 📊 7. Power BI Dashboard

The Power BI solution is organized into **five interactive pages**:

1.  🏠 Sales Analytics Dashboard --- Home
2.  📈 Executive Overview
3.  🏪 Retailer & Product Performance
4.  💰 Pricing & Profitability
5.  🔮 Forecast & Scenario Analysis

------------------------------------------------------------------------

# 🏠 Dashboard Home

The home page acts as the navigation hub for the complete dashboard.

It provides:

-   Overall KPI summary
-   Dashboard navigation
-   Executive Overview access
-   Retailer & Product Performance access
-   Pricing & Profitability access
-   Forecast & Scenario Analysis access
-   Key business themes and navigation shortcuts

```{=html}
<p align="center">
```
`<img src="Images/dashboard-home.png" alt="Adidas Sales Analytics Dashboard Home" width="100%">`{=html}
```{=html}
</p>
```

------------------------------------------------------------------------

# 📈 Executive Overview

The Executive Overview provides a high-level view of business
performance.

### Key KPIs

  KPI                      Value
  --------------- --------------
  Total Sales       **\$120.2M**
  Total Profit       **\$47.2M**
  Units Sold           **2.48M**
  Profit Margin        **\~39%**
  Retailers                **6**
  Sales Growth         **79.9%**

### Analysis Included

-   Monthly Sales Trend
-   Sales by Category
-   Sales by City
-   Sales vs Profit
-   Sales Method Performance

```{=html}
<p align="center">
```
`<img src="Images/executive-overview.png" alt="Adidas Executive Overview Dashboard" width="100%">`{=html}
```{=html}
</p>
```
### Key Insight

The dashboard shows strong growth in the 2021 period compared with 2020,
while also highlighting category, city, and sales-method performance.

------------------------------------------------------------------------

# 🏪 Retailer & Product Performance

This page focuses on the question:

> **"Who and what is driving our sales?"**

### Analysis Included

-   Sales by Retailer
-   Product Category Performance
-   Regional Performance
-   Retailer Sales Contribution
-   Interactive Year filter
-   Region filter
-   City filter
-   Product Category filter
-   Sales Method filter

### Retailer Performance

The leading retailers in the dashboard include:

1.  **West Gear**
2.  **Foot Locker**
3.  **Sports Direct**
4.  **Kohl's**
5.  **Walmart**
6.  **Amazon**

```{=html}
<p align="center">
```
`<img src="Images/retailer-product-performance.png" alt="Adidas Retailer and Product Performance Dashboard" width="100%">`{=html}
```{=html}
</p>
```
### Key Insight

The dashboard identifies a strong contribution from the leading
retailers, helping management understand retailer concentration and
partnership priorities.

------------------------------------------------------------------------

# 💰 Pricing & Profitability

This page answers:

> **"Are we pricing our products effectively and profitably?"**

### Visual Analysis

-   Price vs Units Sold
-   Price vs Profit
-   Category Profit Margin
-   Profit Per Unit
-   Sales vs Profit Margin

### Category Margin

The dashboard shows approximately:

  Category                 Margin
  ------------------- -----------
  Street Footwear       **\~40%**
  Apparel               **\~40%**
  Athletic Footwear     **\~37%**

```{=html}
<p align="center">
```
`<img src="Images/pricing-profitability.png" alt="Adidas Pricing and Profitability Dashboard" width="100%">`{=html}
```{=html}
</p>
```
### Business Value

The analysis helps identify:

-   High-sales products
-   High-margin products
-   Low-margin products
-   Price-performance relationships
-   Products requiring pricing or profitability review

------------------------------------------------------------------------

# 🔮 Forecast & Scenario Analysis

The final page moves from historical reporting toward forward-looking
analysis.

### Forecast KPIs

The dashboard displays:

-   Forecasted Sales for the next 6 months
-   Forecasted Profit
-   Growth versus previous 6-month period

Current dashboard values include approximately:

  Metric                       Dashboard Value
  -------------------------- -----------------
  Forecasted Sales                 **\$66.2M**
  Forecasted Sales Growth            **24.0%**
  Forecasted Profit                **\$27.9M**
  Forecasted Profit Growth           **29.5%**

```{=html}
<p align="center">
```
`<img src="Images/forecast-scenario-analysis.png" alt="Adidas Forecast and Scenario Analysis Dashboard" width="100%">`{=html}
```{=html}
</p>
```

------------------------------------------------------------------------

# 🎛 What-If Scenario Analysis

Two interactive parameters were created:

### 1. Price Change

Users can change the assumed price percentage and observe the estimated
sales impact.

Example shown in the dashboard:

``` text
Price Change = 9%
Estimated Sales ≈ $58.2M
```

### 2. Volume Change

Users can change the assumed sales volume percentage.

Example:

``` text
Volume Change = 10%
Estimated Sales ≈ $58.7M
```

### 3. Combined Scenario

The dashboard combines price and volume assumptions.

Example shown:

``` text
Price Change  = 9%
Volume Change = 10%

Estimated Sales ≈ $63.98M
```

### Why This Matters

Instead of only answering **"What happened?"**, the dashboard can also
support:

> **"What could happen if we change our business assumptions?"**

This makes the dashboard useful for scenario planning and management
decision-making.

------------------------------------------------------------------------

# 📈 Key Business Insights

### 💰 Overall Performance

The dataset represents approximately:

-   **\$120.17M Total Sales**
-   **\$47.22M Operating Profit**
-   **2.48M Units Sold**

### 🏪 Retailer Performance

**West Gear** is the leading retailer in the dashboard, followed by
**Foot Locker** and **Sports Direct**.

### 👟 Product Performance

**Street Footwear** is the largest product category by sales.

### 🌎 Regional Performance

The dashboard enables comparison across:

-   Midwest
-   Northeast
-   South
-   Southeast
-   West

The **West** is the strongest-performing region in the dashboard
analysis.

### 🛒 Sales Method

Online sales represent the strongest sales method in the Executive
Overview.

### 📊 Profitability

Street Footwear and Apparel show approximately 40% aggregate margins,
while Athletic Footwear is comparatively lower at approximately 37%.

### 🔮 Future Planning

Forecast and what-if analysis allow management to evaluate potential
changes in sales under different price and volume assumptions.

------------------------------------------------------------------------

# 🎯 Business Recommendations

Based on the dashboard analysis:

### 1. Strengthen Key Retailer Relationships

Prioritize strategic relationships with the highest-contributing
retailers.

### 2. Continue Investing in Strong Product Categories

Maintain focus on high-performing product categories while monitoring
their profitability.

### 3. Review Lower-Margin Products

Investigate pricing, cost structure, and product positioning for
categories with comparatively lower margins.

### 4. Strengthen Digital Sales

Online sales are a major contributor, creating an opportunity to
continue improving digital sales channels.

### 5. Focus on Regional Opportunities

Investigate lower-performing regions and cities to identify gaps in
demand, distribution, pricing, or product availability.

### 6. Use Scenario Planning Before Major Decisions

Use the Power BI What-If parameters to evaluate price and volume
assumptions before implementing sales or pricing strategies.

------------------------------------------------------------------------

# 📁 Project Structure

A recommended repository structure for this project is:

``` text
Adidas-Sales-Analytics/
│
├── 📂 Dataset/
│   └── Adidas_Sales_Data.xlsx
│
├── 📂 Python/
│   └── Adidas_Sales_Preprocessing.ipynb
│
├── 📂 SQL/
│   └── queries.sql
│
├── 📂 PowerBI/
│   └── Adidas_Sales_Analytics.pbix
│
├── 📂 Report/
│   └── Adidas_Sales_Analytics_Project_Report.pdf
│
├── 📂 Presentation/
│   └── Presentation.pdf
│
├── 📂 Images/
│   ├── dashboard-home.png
│   ├── executive-overview.png
│   ├── retailer-product-performance.png
│   ├── pricing-profitability.png
│   └── forecast-scenario-analysis.png
│
└── README.md
```

> Rename or remove files in this structure according to the files
> actually committed to your repository.

------------------------------------------------------------------------

# 💻 Installation

Clone the repository:

``` bash
git clone https://github.com/yourusername/Adidas-Sales-Analytics.git
```

Move into the project:

``` bash
cd Adidas-Sales-Analytics
```

Install the Python dependencies:

``` bash
pip install pandas numpy matplotlib seaborn sqlalchemy psycopg2-binary openpyxl
```

------------------------------------------------------------------------

# ▶️ How to Run

### Step 1 --- Prepare the Dataset

Place:

``` text
Adidas_Sales_Data.xlsx
```

inside the `Dataset` or working directory expected by the notebook.

### Step 2 --- Run Python Preprocessing

Open:

``` text
Python/Adidas_Sales_Preprocessing.ipynb
```

Run the cells in order to:

-   Load the dataset
-   Inspect the data
-   Validate data quality
-   Standardize column names
-   Convert dates
-   Create date features
-   Create revenue/profit features
-   Load the processed data into PostgreSQL

### Step 3 --- Configure PostgreSQL

Create the required database and update the local connection settings in
your own environment.

**Do not commit passwords or credentials to GitHub.**

### Step 4 --- Open Power BI

Open the Power BI `.pbix` file and refresh the data connection if
required.

### Step 5 --- Explore the Dashboard

Navigate through:

``` text
Home
 ↓
Executive Overview
 ↓
Retailer & Product Performance
 ↓
Pricing & Profitability
 ↓
Forecast & Scenario Analysis
```

------------------------------------------------------------------------

# 📚 Skills Demonstrated

-   ✔ Python
-   ✔ Pandas
-   ✔ Data Cleaning
-   ✔ Data Preprocessing
-   ✔ Feature Engineering
-   ✔ Exploratory Data Analysis
-   ✔ SQL
-   ✔ PostgreSQL
-   ✔ Database Integration
-   ✔ Power BI
-   ✔ DAX
-   ✔ KPI Development
-   ✔ Data Visualization
-   ✔ Dashboard Design
-   ✔ Forecasting
-   ✔ What-If Analysis
-   ✔ Business Analysis
-   ✔ Data Storytelling

------------------------------------------------------------------------

# 🎓 Learning Outcomes

This project demonstrates practical experience in:

-   Working with a real-world structured sales dataset
-   Performing data quality checks
-   Preparing data using Python/Pandas
-   Engineering analytical features
-   Integrating processed data with PostgreSQL
-   Building Power BI analytical dashboards
-   Creating dynamic KPI measures
-   Performing retailer, product, regional and pricing analysis
-   Building forecast and scenario analysis
-   Translating analytical results into business recommendations
-   Communicating insights through data storytelling

------------------------------------------------------------------------

# 🔮 Future Improvements

Potential extensions include:

-   🤖 Machine Learning-based demand forecasting
-   📦 Product-level demand prediction
-   📊 Automated ETL pipeline
-   ☁️ Cloud database integration
-   🔄 Automated Power BI refresh
-   📡 Near-real-time analytics
-   🧠 Customer segmentation
-   📦 Inventory optimization
-   💹 Price elasticity analysis
-   🌐 Streamlit analytical application
-   🔌 API-based data ingestion

------------------------------------------------------------------------

# 👨‍💻 Author

**Enbashakaran**

**Data Analyst \| Business Intelligence \| Python \| SQL \| Power BI**

📧 **enbashakaran04@gmail.com**

🔗 [LinkedIn](https://www.linkedin.com/in/enbashakaran-t-0b9940374/)

💻 [GitHub](https://github.com/Enbashakaran-Engineer)

------------------------------------------------------------------------

# ⭐ Support

If you found this project useful, consider giving the repository a ⭐ on
GitHub.

It helps others discover the project and supports continued development.

------------------------------------------------------------------------

## 📜 License

This project is intended for learning, portfolio, and demonstration
purposes.

If you publish it under the MIT License, add the standard MIT `LICENSE`
file to the repository.
