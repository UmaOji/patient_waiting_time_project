-- 1. Does the Patient Type Affect the Waiting Time?
SELECT DISTINCT patient_type
FROM hospital_db.patients;

-- 2.  Average Waiting Time by Doctor Type 
SELECT doctor_type, 
	FORMAT(AVG(TIMESTAMPDIFF(SECOND, entry_time, post_consultation_time)) / 60, 3) AS avg_wait_time_minutes
FROM hospital_db.patients
GROUP BY doctor_type;

-- 3. Total Revenue by Financial Class
SELECT financial_class,
	SUM(medication_revenue + consultation_revenue) AS total_revenue
FROM hospital_db.patients
GROUP BY financial_class
ORDER BY total_revenue;

-- 4. Does the Financial Class of the Patient Increase Expenses?
SELECT financial_class, 
	FORMAT(SUM(medication_revenue), 2) AS total_medication_revenue,
	FORMAT(SUM(consultation_revenue), 2) AS total_consultation_revenue,
	FORMAT(SUM(medication_revenue) + SUM(consultation_revenue), 2) AS total_patient_expenses
	# Format() function used to return values with a thousand seperator and specify number of decimal places 
FROM hospital_db.patients
GROUP BY financial_class
ORDER BY SUM(medication_revenue) + SUM(consultation_revenue) DESC;

-- 5. Top 5 Most Frequent Days for Entries
SELECT DAYNAME(entry_date) AS dayofweek, 
	COUNT(*) AS entries_count
FROM hospital_db.patients
GROUP BY DAYNAME(entry_date)
ORDER BY entries_count DESC
LIMIT 5;

-- 6. Correlation Between Entry Time and Wait Time
SELECT HOUR(entry_time) AS hour_of_day, 
       ROUND(AVG(TIMESTAMPDIFF(MINUTE, entry_time, post_consultation_time)), 2) AS avg_wait_time_minutes
FROM hospital_db.patients
GROUP BY HOUR(entry_time)
ORDER BY avg_wait_time_minutes DESC
LIMIT 5;

-- 7. Patient Wait Time Trends Over Time
SELECT entry_date, 
	ROUND(AVG(TIMESTAMPDIFF(SECOND, entry_time, post_consultation_time)) / 60, 3) AS avg_wait_time_minutes
FROM hospital_db.patients
GROUP BY entry_date
ORDER BY entry_date;

-- 8. Revenue Vs. Wait Time
SELECT 
    CASE 
        WHEN total_revenue >= (SELECT MAX(total_revenue) * 0.67 FROM (
				SELECT SUM(medication_revenue + consultation_revenue) AS total_revenue
                -- Multiplying the maximum revenue by 0.67 for the high threshold (top 33%)
                FROM hospital_db.patients
                GROUP BY patient_id
            ) AS revenue_summary
        ) THEN 'High Expenses'
        
        WHEN total_revenue >= (SELECT MAX(total_revenue) * 0.33 FROM (
                SELECT SUM(medication_revenue + consultation_revenue) AS total_revenue
                -- Multiplying the maximum revenue by 0.33 for the middle threshold (middle 33%)
                FROM hospital_db.patients
                GROUP BY patient_id
            ) AS revenue_summary
        ) THEN 'Middle Expenses'
        
        ELSE 'Low Expenses'
    END AS expense_category,
    
    ROUND(AVG(TIMESTAMPDIFF(SECOND, entry_time, post_consultation_time)) / 60, 2) AS avg_wait_time_minutes
FROM (
    SELECT 
        patient_id,
        SUM(medication_revenue + consultation_revenue) AS total_revenue,
        entry_time,
        post_consultation_time
    FROM hospital_db.patients
    GROUP BY patient_id
) AS patient_revenue_summary
GROUP BY expense_category;