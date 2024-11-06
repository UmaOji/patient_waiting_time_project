# Patient Waiting Time Project
## About
The **Patient Waiting Time** project aims to analyze patient waiting times at a healthcare facility. The dataset includes critical information such as **Doctor Type**, **Patient Type**, **Entry Time**, and **Completion Time**. This analysis will help identify factors affecting waiting times, determine staffing needs, and suggest potential improvements to enhance patient experience.

## Table of Contents
- [Introduction](#introduction)
   - [Brief Overview of The Project](#brief-overview-of-the-project)
   - [Purpose of The Project](#purpose-of-the-project)
   - [Dataset Source](#dataset-source)

2. **Data Preparation**
   - Loading Data
   - Exploring Raw Data
   - Cleaning Data
   - Data Transformation

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
   - Summary of Findings
   - Visualizations (if applicable)

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

      1. **Handling Null or Placeholder Values**:
         - The `lab_cost` column contained rows where entries had only the `$` symbol, which was replaced with `NULL` to ensure data consistency.
         - Used the following SQL query for this transformation:
           ```sql
           UPDATE patients
           SET lab_cost = NULL
           WHERE lab_cost = '$';
           ```

      2. **Standardizing Date and Time Formats**:
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

   3. **Converting Data Types**:
         - Adjusted `patient_id` to accommodate text-based identifiers that use a combination of letters and numbers (e.g., `C10001`).
         - Verified the format with:
           ```sql
           SELECT patient_id
           FROM patients
           WHERE patient_id NOT REGEXP '^C[0-9]+$';
           ```

      4. **Removing Duplicates**:
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

