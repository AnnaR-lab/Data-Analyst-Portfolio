# Data-Analyst-Portfolio
## About

Hi, I'm Anna. I'm currently studying to become a Data Analyst and exploring key tools such as Python, R, Tableau, and SQL.

I have a background in geology and several years of experience in the petroleum industry. Geology is also a form of data analytics — geologists interpret indirect measurements to understand reservoir behavior and make production forecasts.

Here, I share some of my learning projects and insights along the way.

## Portfolio Projects
In this section I share my data analysis projects.

### Practicing EDA of Chips Sales in Cyprus Peripteros using R
This is a self-study project as part of my learning path in data analytics. The dataset is a simplified and anonymized version of retail sales from a peripteros, focused only on chips as a product category. The data was synthetic and does not contain sensitive or real company information
#### **Code 🔗:** 
- 🧹 [Data Cleaning Script](1_Clean_Data.R)
- 📊 [Exploratory Data Analysis Script](2_EDA.R)
#### **Goal:** 
To analyse sales data for chips from a small convenience stores (periptero) in Cyprus. The aim is to identify key customer segments, trends over time, and popular products.
#### **Description:** 
This project consists of two main steps:

1️⃣ Data Cleaning: cleaning transaction dates; merging transaction data with customer information

2️⃣ Exploratory Data Analysis (EDA): grouping sales by product, months, day of the week; visualizing daily, weekly, and monthly sales; segmenting customers and identifying their product preferences

#### **Result:**
[Customer segmentation analysis](/pics/Customer_Segments.png) revealed distinct purchasing patterns:

1. Young Families and Young Singles/Couples contributed significantly to total chip sales across all budget segments.
2. Retirees and Older Families made up a large share of sales in the Mainstream and Budget segments.
3. Premium customers were mostly represented by Older Singles/Couples and Young Couples.

The most active customer segments in terms of volume were:
1. Mainstream Older Families
2. Budget Young Singles/Couples
3. Mainstream Retirees

These insights can help target marketing efforts based on both budget level and lifestage group.


### **🌍 Cosmic Scars: Meteor Craters of Earth. **
Practicing Data Visualization with Tableau

#### **Goal:** 
To study and systematize the basic data on impact craters on Earth.

#### **Description:** 
This project visualizes meteorite impact craters around the world using publicly available geological data. Key features of the dashboard:
- Interactive map with buffer zones representing area of impact (buffer zone scale 1:5)
- Distribution of crater ages in geological time
- Top craters by diameter and age
- Visual encoding of extinction events and crater frequency by geological time

The data was pre-processed in Google Sheets, raw coordinates were converted to decimal format for Tableau, geological age was matched to time periods for accurate categorization. Tableau was used to create multi-layer visualizations, spatial analysis (using BUFFER) and custom tooltips.

#### **Result:**
An interactive and informative Tableau dashboard titled "Cosmic Scars: Meteor Craters of Earth", published on Tableau Public:
🔗 [View Dashboard](https://public.tableau.com/views/CosmicScarsMeteorCratersofEarth/CosmicScarsMeteorCratersofEarth?:language=en-GB&:sid=0D1BD2FAE6394E04ADE13A8CD017CD21-0:0&:redirect=auth&:display_count=n&:origin=viz_share_link)
