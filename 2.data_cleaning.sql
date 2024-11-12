-- Update `lab_cost` column; replace any entries with '$' only with 0
UPDATE hospital_db.patients
SET lab_cost = 0  -- or use 'NULL' if you prefer
WHERE lab_cost = '$';

-- Check for any entries with incorrect date or time formats
SELECT *
FROM hospital_db.patients
WHERE entry_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' 
   OR entry_time NOT REGEXP '^[0-9]{2}:[0-9]{2}:[0-9]{2}$'
   OR post_consultation_time NOT REGEXP '^[0-9]{2}:[0-9]{2}:[0-9]{2}$'
   OR completion_time NOT REGEXP '^[0-9]{2}:[0-9]{2}:[0-9]{2}$';

-- Find potential duplicates based on key columns
SELECT patient_id, entry_date, completion_time, COUNT(*)
FROM hospital_db.patients
GROUP BY patient_id, entry_date, completion_time
HAVING COUNT(*) > 1;
