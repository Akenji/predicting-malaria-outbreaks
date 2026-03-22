-- Malaria Outbreak Prediction Database Schema
-- Run this script in MySQL Workbench to create the database and all tables

-- Create the database
CREATE DATABASE IF NOT EXISTS malaria;
USE malaria;

-- Create dimension tables

-- Dimension: Dates
CREATE TABLE IF NOT EXISTS dim_dates (
    Date_key INT PRIMARY KEY,
    Full_date DATE NOT NULL,
    Year INT NOT NULL,
    Month INT NOT NULL,
    Month_name VARCHAR(20) NOT NULL,
    Week_number INT NOT NULL,
    Season VARCHAR(20),
    Is_rainy_season VARCHAR(10),
    INDEX idx_full_date (Full_date)
);

-- Dimension: Location
CREATE TABLE IF NOT EXISTS dim_location (
    Location_key INT PRIMARY KEY,
    Region_name VARCHAR(100) NOT NULL,
    District VARCHAR(100) NOT NULL,
    Population_density DECIMAL(10, 2),
    Terrain_type VARCHAR(50),
    Distance_to_water DECIMAL(10, 2),
    INDEX idx_region (Region_name),
    INDEX idx_district (District)
);

-- Dimension: Demographics
CREATE TABLE IF NOT EXISTS dim_demographics (
    Demographic_key INT PRIMARY KEY,
    Age_group VARCHAR(50),
    Socio_economic_status VARCHAR(50),
    Vaccination_rate DECIMAL(5, 2),
    Housing_type VARCHAR(50),
    INDEX idx_age_group (Age_group),
    INDEX idx_ses (Socio_economic_status)
);

-- Dimension: Weather
CREATE TABLE IF NOT EXISTS dim_weather (
    Weather_key INT PRIMARY KEY,
    Temperature DECIMAL(5, 2),
    Humidity DECIMAL(5, 2),
    Rainfall DECIMAL(10, 2),
    Wind_speed DECIMAL(5, 2),
    Weather_pattern VARCHAR(50),
    INDEX idx_weather_pattern (Weather_pattern)
);

-- Dimension: Healthcare
CREATE TABLE IF NOT EXISTS dim_healthcare (
    Healthcare_key INT PRIMARY KEY,
    Facility_name VARCHAR(100),
    Bed_capacity INT,
    Medical_staff INT,
    Antimalarial_stock INT,
    Has_lab_facilities BOOLEAN,
    Distance_to_communities DECIMAL(10, 2),
    INDEX idx_facility_name (Facility_name)
);

-- Dimension: Socioeconomic
CREATE TABLE IF NOT EXISTS dim_socioeconomic (
    Socioeconomic_key INT PRIMARY KEY,
    Employment_rate DECIMAL(5, 2),
    Income_level VARCHAR(50),
    Education_level VARCHAR(50),
    Access_to_healthcare BOOLEAN,
    INDEX idx_income_level (Income_level),
    INDEX idx_education (Education_level)
);

-- Dimension: Environment
CREATE TABLE IF NOT EXISTS dim_environment (
    Environment_key INT PRIMARY KEY,
    Population_level VARCHAR(50),
    Land_use_type VARCHAR(50),
    Vegetation_type VARCHAR(50),
    INDEX idx_land_use (Land_use_type)
);

-- Dimension: Prevention
CREATE TABLE IF NOT EXISTS dim_prevention (
    Prevention_key INT PRIMARY KEY,
    Nets_distributed INT,
    Spray_coverage DECIMAL(5, 2),
    Control_method VARCHAR(100),
    Last_campaign_date DATE,
    INDEX idx_control_method (Control_method)
);

-- Dimension: Infrastructure
CREATE TABLE IF NOT EXISTS dim_infrastructure (
    Infrastructure_key INT PRIMARY KEY,
    Road_quality VARCHAR(50),
    Access_to_water BOOLEAN,
    Access_to_electricity BOOLEAN,
    Communication_coverage VARCHAR(50),
    INDEX idx_road_quality (Road_quality)
);

-- Dimension: Health Initiatives
CREATE TABLE IF NOT EXISTS dim_health_initiatives (
    Initiative_key INT PRIMARY KEY,
    Initiative_name VARCHAR(255),
    Start_date DATE,
    End_date DATE,
    Coverage_percentage DECIMAL(5, 2),
    INDEX idx_initiative_name (Initiative_name)
);

-- Create Fact Table
CREATE TABLE IF NOT EXISTS fact_malaria_cases (
    Case_key INT PRIMARY KEY,
    Location_key INT NOT NULL,
    Date_key INT NOT NULL,
    Weather_key INT NOT NULL,
    Healthcare_key INT NOT NULL,
    Prevention_key INT NOT NULL,
    Demographic_key INT NOT NULL,
    Infrastructure_key INT NOT NULL,
    Socioeconomic_key INT NOT NULL,
    Environment_key INT NOT NULL,
    Initiative_key INT NOT NULL,
    Diagnosed_cases INT,
    Severe_cases INT,
    Deaths INT,
    Infection_rate DECIMAL(10, 2),
    Outbreak_status BOOLEAN,
    
    -- Foreign Key Constraints
    CONSTRAINT fk_fact_location FOREIGN KEY (Location_key) 
        REFERENCES dim_location(Location_key) ON DELETE RESTRICT,
    CONSTRAINT fk_fact_date FOREIGN KEY (Date_key) 
        REFERENCES dim_dates(Date_key) ON DELETE RESTRICT,
    CONSTRAINT fk_fact_weather FOREIGN KEY (Weather_key) 
        REFERENCES dim_weather(Weather_key) ON DELETE RESTRICT,
    CONSTRAINT fk_fact_healthcare FOREIGN KEY (Healthcare_key) 
        REFERENCES dim_healthcare(Healthcare_key) ON DELETE RESTRICT,
    CONSTRAINT fk_fact_prevention FOREIGN KEY (Prevention_key) 
        REFERENCES dim_prevention(Prevention_key) ON DELETE RESTRICT,
    CONSTRAINT fk_fact_demographic FOREIGN KEY (Demographic_key) 
        REFERENCES dim_demographics(Demographic_key) ON DELETE RESTRICT,
    CONSTRAINT fk_fact_infrastructure FOREIGN KEY (Infrastructure_key) 
        REFERENCES dim_infrastructure(Infrastructure_key) ON DELETE RESTRICT,
    CONSTRAINT fk_fact_socioeconomic FOREIGN KEY (Socioeconomic_key) 
        REFERENCES dim_socioeconomic(Socioeconomic_key) ON DELETE RESTRICT,
    CONSTRAINT fk_fact_environment FOREIGN KEY (Environment_key) 
        REFERENCES dim_environment(Environment_key) ON DELETE RESTRICT,
    CONSTRAINT fk_fact_initiative FOREIGN KEY (Initiative_key) 
        REFERENCES dim_health_initiatives(Initiative_key) ON DELETE RESTRICT,
    
    -- Indexes for better query performance
    INDEX idx_location (Location_key),
    INDEX idx_date (Date_key),
    INDEX idx_outbreak_status (Outbreak_status),
    INDEX idx_date_location (Date_key, Location_key)
);

-- Verify tables were created
SHOW TABLES;
