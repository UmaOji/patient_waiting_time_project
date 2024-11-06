CREATE DATABASE hospital_db;

USE hospital_db;

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
DROP TABLE IF EXISTS patients;

CREATE TABLE patients (
    entry_date DATE,
    medication_revenue DECIMAL(10, 2),
    lab_cost DECIMAL(10, 2) NULL,
    consultation_revenue DECIMAL(10, 2),
    doctor_type VARCHAR(100),
    financial_class VARCHAR(100),
    patient_type VARCHAR(100),
    entry_time TIME,
    post_consultation_time TIME,
    completion_time TIME,
    patient_id VARCHAR(20) PRIMARY KEY
);