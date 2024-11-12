-- Create the database
CREATE DATABASE hospital_db;

-- Use the created database
USE hospital_db;

-- Drop the table if it exists and recreate the patients table
DROP TABLE IF EXISTS patients;

-- Create a patients table
CREATE TABLE patients (
    entry_date DATE,
    medication_revenue DECIMAL(10, 2),
    lab_cost DECIMAL(10, 2),
    consultation_revenue DECIMAL(10, 2),
    doctor_type VARCHAR(50),
    financial_class VARCHAR(50),
    patient_type VARCHAR(50),
    entry_time TIME,
    post_consultation_time TIME,
    completion_time TIME,
    patient_id INT PRIMARY KEY
);
-- Drop the table if it exists and recreate the patients table
DROP TABLE IF EXISTS patients;

-- Create a new patients table
CREATE TABLE patients (
    entry_date DATE,
    medication_revenue DECIMAL(10, 2), -- Allows up to 8 digits before the decimal point and 2 digits after
    lab_cost DECIMAL(10, 2) NULL,
    consultation_revenue DECIMAL(10, 2),
    doctor_type VARCHAR(100),
    financial_class VARCHAR(100), -- Allows up tom 100 characters
    patient_type VARCHAR(100),
    entry_time TIME,
    post_consultation_time TIME,
    completion_time TIME,
    patient_id VARCHAR(20) PRIMARY KEY -- Changed patient_id field from INT to VARCHAR(20) because it contianed both text and numbers (eg. C10015)
);