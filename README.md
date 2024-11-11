# Patient Waiting Time Project
## About
The **Patient Waiting Time** project aims to analyze patient waiting times at a healthcare facility. The dataset includes critical information such as **Doctor Type**, **Patient Type**, **Entry Time**, and **Completion Time**. This analysis will help identify factors affecting waiting times, determine staffing needs, and suggest potential improvements to enhance patient experience.

## Table of Contents
- [Introduction](#introduction)
   - [Brief Overview of The Project](#brief-overview-of-the-project)
   - [Purpose of The Project](#purpose-of-the-project)
   - [Dataset Source](#dataset-source)
- [Data Preparation](#data-preparation)
   - [Loading Data](#loading-data)
   - [Exploring Raw Data](#exploring-raw-data)
   - [Cleaning Data](#cleaning-data)

3. **Analysis Questions**
   - Does the patient type affect the waiting time?
   - Is there a specific type of patient waiting a long time?
   - Are we too busy?
   - Do we have staffing issues?
   - How much time do patients wait before seeing the doctor?
   - What type of staff do we need or where do we need them?
   - What days of the week are affected?
   - How can we fix it?

4. **Methodology**
   - SQL Queries for Data Analysis
   - Techniques Used for Cleaning and Analyzing Data

5. **Results**
   - Summary of Key Findings
   - Visualizations & Insights (if applicable)

6. **Conclusion**
   - Recommendations Based on Findings
   - Next Steps for Implementation

7. **References**
   - Data Sources
   - Related Literature

8. **Acknowledgments**
   - Contributors
   - Support and Resources
    
9. **License**
   - Information about the project license if applicable.

## Introduction

#### Brief Overview of The Project
The Patient Waiting Time project focuses on analyzing the duration patients wait to see a doctor, identifying trends, and understanding the factors that contribute to varying waiting times.

#### Purpose of The Project
This project analyzes patient waiting times to uncover patterns and identify the underlying factors contributing to delays. Healthcare facilities can implement strategies to enhance patient experience, optimize resource allocation, and improve overall operational efficiency by understanding these dynamics. 

#### Dataset Source
The dataset used for this project is titled **Hospital Patient Data** and can be accessed on Kaggle at the following link: [Hospital Patient Data](https://www.kaggle.com/datasets/abdulqaderasiirii/hospital-patient-data). This dataset encompasses a comprehensive collection of data from patients entering the hospital until their exit. It was updated 2 years ago by **Abdulqader Asiirii**.

---

## Data Preparation
#### Loading Data
   - Database Setup: Created a database named patient_db in MySQL (later renamed hospital_db).
   - Table Creation: Define the patients' table using the appropriate data types for each column.
   - Data Import: Imported approximately 5,436 rows from the original dataset. Due to size constraints, only a portion of the full dataset was loaded.
   - File Splitting: Large dataset handling is planned using Excel to split files if additional data is required.

#### Exploring Raw Data
   - Column Overview: Inspected column types and sample entries, confirming that certain columns, like lab_cost, contain non-numeric characters ($) in most rows, which need further cleaning.
   - Data Types Review: Adjusted column data types to align with the dataset (e.g., treating patient_id as a VARCHAR due to mixed text and numeric values).

#### Cleaning Data
   - **Objective**: Prepare the dataset for analysis by addressing any inconsistencies, standardizing formats, and handling missing or placeholder values.

   - **Steps Taken**:

     i. **Handling Null or Placeholder Values**:
         - The `lab_cost` column contained rows where entries had only the `$` symbol, which was replaced with `NULL` to ensure data consistency.
         - Used the following SQL query for this transformation:
     ```sql
           UPDATE patients
           SET lab_cost = NULL
           WHERE lab_cost = '$';
     ```

     ii. **Standardizing Date and Time Formats**:
         - Ensured `entry_date` and time-related columns (`entry_time`, `post_consultation_time`, `completion_time`) were stored in valid date and time formats.
         - Queried for any entries that didn’t match standard date or time formats using:

        ```sql
           SELECT *
           FROM patients
           WHERE entry_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$'
              OR entry_time NOT REGEXP '^[0-9]{2}:[0-9]{2}:[0-9]{2}$'
              OR post_consultation_time NOT REGEXP '^[0-9]{2}:[0-9]{2}:[0-9]{2}$'
              OR completion_time NOT REGEXP '^[0-9]{2}:[0-9]{2}:[0-9]{2}$';
        ```
> [!NOTE]  
> I changed these formats in **Excel** before importing into MySQL to ensure everything was intact before beginning the analysis. This was done to ensure proper data interpretation during import, especially for date and time values.

 iii. **Removing Duplicates**:
   - Checked for duplicate records based on the combination of `patient_id`, `entry_date`, and `completion_time`.
   - Identified duplicates using:
     ```sql
        SELECT patient_id, entry_date, completion_time, COUNT(*)
        FROM patients
        GROUP BY patient_id, entry_date, completion_time
        HAVING COUNT(*) > 1;
     ```

This **Data Cleaning** process was essential to prepare a consistent, analysis-ready dataset that would yield accurate insights in the subsequent analysis steps.

---

## Analysis Questions
#### 1. Does the patient type affect the waiting time?
In this dataset, the **patient type** does not affect the waiting time because all the patients are **OUTPATIENTS**. Outpatients are people who come in for medical care but don’t need to stay overnight in the hospital. Since everyone in the dataset is the same type of patient (outpatient), there is no difference in waiting times based on patient type. Since there are no inpatient patients in the data, patient type does not affect the waiting times in this case.

#### 2.

#### 3. Is there a specific type of patient waiting a long time?

#### 4. Average Wait Time by Doctor Type
**Purpose**:  
Calculate the average wait time by doctor type to identify potential delays in patient care.

**Findings**:
- **Floating**: 75 hours, 21 minutes
- **Locum**: 535 hours, 56 minutes, 59 seconds
- **Anchor**: 838 hours, 59 minutes, 59 seconds

**Interpretation**:  
Locum and Anchor doctors have significantly longer wait times than Floating doctors, suggesting potential inefficiencies or higher patient loads.

**Recommendation**:  
Review staffing and scheduling to balance the workload more effectively.

#### 5. Total Revenue by Financial Class
**Purpose:**
This query calculates the total revenue generated by each financial class and explores whether there is any relationship between financial class and patient wait times.

**Interpretation:**
The query reveals which financial classes contribute the most revenue, and by comparing this with wait time data, it helps identify whether higher-revenue classes also face longer wait times. If a correlation exists, it could suggest that patients from higher-revenue classes experience longer wait times due to increased service demands.

**Recommendation:**
Consider analyzing the relationship between financial class and wait times. If certain classes consistently have higher wait times, adjustments in scheduling or staffing may be needed to balance service delivery.

#### 6. Does the financial class of patients affect total expenses?
Patients who pay with **INSURANCE** have the highest combined revenue for both medication and consultation, totalling **$210,831.98**. This suggests that insurance-covered patients are generating the highest revenue for the healthcare providers compared to the other financial classes, such as **HMO**, **CORPORATE**, and **MEDICARE**.

The total revenue generated from medication and consultation combined are as follows:
- **INSURANCE**: $210,831.98
- **HMO**: $111,232.43
- **CORPORATE**: $104,079.89
- **MEDICARE**: $21,932.11 (Lowest revenue)

So, **insurance** patients are the biggest contributors in terms of total revenue generated from both medication and consultation, which could be an important insight for healthcare providers when analyzing financial performance by patient type.

#### 7. ### Documentation for **Top 5 Most Frequent Days for Entries**
**Purpose**:  
This query identifies the top 5 days of the week with the highest number of patient entries, providing insight into which days are busiest.

**Interpretation**:  
- **Monday** has the highest number of entries at **1,297**.
- **Tuesday** follows with **1,056** entries, while **Friday** sees **890** entries.
- **Wednesday** and **Saturday** have comparatively fewer entries, with **762** and **545** respectively.

This information can help the hospital prepare for busier days by adjusting staffing levels and resources to better manage the patient load.

**Recommendation**:  
Allocate additional resources on **Monday** and **Tuesday** to handle the higher patient volume and ensure shorter wait times.

#### 8. Revenue Vs. Wait Time
This code is designed to help analyze patient data by looking at how waiting times relate to patient expenses. It aims to understand whether patients with higher expenses tend to have longer waiting times or if there’s any noticeable difference across expense categories.

### Explanation of Code Steps
1. **Grouping Patients by Expense Level**:
   - First, calculate each patient’s total expense by combining their `medication_revenue` and `consultation_revenue`.
   - Based on these total expenses, each patient is classified into one of three categories: **High Expenses**, **Middle Expenses**, or **Low Expenses**. This allows us to easily compare waiting times across different financial classes.

In the context of categorizing expenses, a threshold is a cutoff value that we set to define boundaries between different categories. For example, if we're dividing patients into *High*, *Middle*, and *Low Expense* categories based on their total expenses, we need specific thresholds to determine what counts as "high," "middle," and "low."

2. **Calculating Average Waiting Time**:
   - For each expense category, we calculate the average waiting time in minutes. This is done by finding the time difference between when each patient entered the hospital (`entry_time`) and when their consultation was completed (`post_consultation_time`). 
   - The time difference is then averaged within each expense group, giving a summary of waiting times per category.

3. **Sorting and Displaying Results**:
   - The results are shown in a simple table, ordered by expense category. This makes it easy to see if there’s any correlation between higher expenses and waiting times.

### Results

The output from this analysis looks like this:

| Expense Category | Average Wait Time (minutes)   |
|------------------|:-----------------------------:|
| High Expenses    | 42.15                         |
| Middle Expenses  | 49.58                         |
| Low Expenses     | 42.40                         |

These findings show that **patients with middle-range expenses had the highest average waiting time**, whereas high and low-expense groups had slightly shorter average waits. This result suggests that expense levels alone might not be the main factor driving wait times. 

---

