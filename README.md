# Malaria Outbreak Prediction Model

A machine learning system that predicts malaria outbreaks in Cameroon using environmental, healthcare, and socioeconomic factors through Random Forest classification.

## Project Structure

```
MALARIA/
├── .scannerwork/
├── venv/
├── .coverage
├── cleaning.py                # Data cleaning & feature preprocessing
├── confusion_matrix.png       # Saved confusion matrix from model training
├── coverage.xml
├── database_schema.sql        # MySQL schema for all dim/fact tables
├── dim_dates.csv
├── dim_demographics.csv
├── dim_environment.csv
├── dim_health_initiatives.csv
├── dim_healthcare.csv
├── dim_infrastructure.csv
├── dim_location.csv
├── dim_prevention.csv
├── dim_socioeconomic.csv
├── dim_weather.csv
├── fact_malaria_cases.csv
├── feature_importance.csv     # Exported feature importance scores
├── feature_importance.png     # Feature importance plot
├── loading.py                 # ETL: load all CSVs into MySQL
├── malaria_prediction_model.py# Train & evaluate Random Forest model
├── predict_malaria.py         # CLI tool for interactive risk prediction
├── processed_data.csv         # Fully processed dataset (optional artifact)
├── requirements.txt           # Python dependencies
└── test_malaria_db.py         # Pytest suite for ETL & preprocessing
```

## Overview

This project implements a predictive model for malaria outbreak detection using machine learning techniques. The system analyzes multiple dimensions of data including:
- Environmental factors
- Demographic information
- Healthcare accessibility
- Infrastructure data
- Prevention measures
- Socioeconomic indicators
- Weather patterns

## Data Sources

The project uses a dimensional data model with the following key files:
- **Fact Table**: fact_malaria_cases.csv - Contains the main malaria case records
- **Dimension Tables**:
  - dim_dates.csv - Temporal dimensions
  - dim_demographics.csv - Population demographics
  - dim_environment.csv - Environmental factors
  - dim_health_initiatives.csv - Health programs and initiatives
  - dim_healthcare.csv - Healthcare facility information
  - dim_infrastructure.csv - Infrastructure availability
  - dim_location.csv - Geographical information
  - dim_prevention.csv - Malaria prevention measures
  - dim_socioeconomic.csv - Socioeconomic indicators
  - dim_weather.csv - Weather-related data

## Key Components

### Data Processing
- **cleaning.py**: Handles data cleaning, table joins and feature preprocessing
- **loading.py**: Loads all CSV source files into the MySQL `malaria` database

### Model
- **malaria_prediction_model.py**: Trains and evaluates the Random Forest outbreak classifier
- **predict_malaria.py**: Interactive CLI that uses the trained model to estimate outbreak risk
- **test_malaria_db.py**: Pytest suite for ETL and preprocessing logic

### Analysis Outputs
- **confusion_matrix.png**: Visual representation of model performance
- **feature_importance.csv**: Detailed feature importance scores
- **feature_importance.png**: Visual representation of feature importance
- **processed_data.csv**: Final processed dataset used for modeling

## Installation

1. Clone the repository
2. Create a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install required Python dependencies:
```bash
pip install -r requirements.txt
```

4. Install and configure MySQL:
  - Install MySQL Server (5.7+ or 8.x)
  - Ensure the server is running on `127.0.0.1`
  - By default, the scripts expect:
    - user: `root`
    - password: `your root password`
    - database: `malaria`
  - If your credentials differ, update the connection settings in:
    - `cleaning.py`
    - `loading.py`
    - `malaria_prediction_model.py`

5. Create the `malaria` schema and tables in MySQL:
  - Open `database_schema.sql` in MySQL Workbench (or another client)
  - Execute the entire script to create all `dim_*` tables and `fact_malaria_cases`

## Usage

1. Load all CSV data into MySQL:
```bash
python loading.py
```

2. (Optional) Build a fully processed CSV for offline analysis:
```bash
python cleaning.py
```

3. Train and evaluate the Random Forest model:
```bash
python malaria_prediction_model.py
```

  This will:
  - Simulate 2 years of historical data
  - Train a Random Forest with class balancing (SMOTE) and GridSearchCV
  - Save the best model to `malaria_model.pkl`
  - Generate updated `feature_importance.png` and `confusion_matrix.png`

4. Run the interactive prediction CLI (after `malaria_model.pkl` exists):
```bash
python predict_malaria.py
```

  You will be prompted for environmental, healthcare and socioeconomic inputs,
  and the tool will display an outbreak risk level and recommended actions.

5. Run Tests:
```bash
python -m pytest test_malaria_db.py
```

## Model Evaluation

Model performance metrics and visualizations can be found in:
- **confusion_matrix.png** - For model accuracy evaluation
- **feature_importance.png** - For understanding feature significance

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Note**: This project uses dimensional modeling for data organization. Make sure all dimension tables are properly loaded before running the fact table integration.

