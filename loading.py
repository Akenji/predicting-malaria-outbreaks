import pandas as pd
import mysql.connector


def get_db_connection():
    return mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="sql80",
        database="malaria",
    )


def load_csv_to_db(file_path, table_name, db_connection=None):
    df = pd.read_csv(file_path)

    columns = ', '.join(df.columns)
    placeholders = ', '.join(['%s'] * len(df.columns))
    insert_query = f"INSERT IGNORE INTO {table_name} ({columns}) VALUES ({placeholders})"

    created_connection = False
    if db_connection is None:
        db_connection = get_db_connection()
        created_connection = True

    cursor = db_connection.cursor()

    for row in df.itertuples(index=False):
        try:
            cursor.execute(insert_query, tuple(row))
        except mysql.connector.Error as err:
            print(f"Error inserting row into {table_name}: {err}")
            continue

    db_connection.commit()
    print(f"Data from {file_path} inserted into {table_name} table.")

    if created_connection:
        cursor.close()
        db_connection.close()

# Step 4: Define file paths and table names
csv_files = {
    'dim_dates.csv': 'dim_dates',
    'dim_demographics.csv': 'dim_demographics',
    'dim_environment.csv': 'dim_environment',
    'dim_health_initiatives.csv': 'dim_health_initiatives',
    'dim_healthcare.csv': 'dim_healthcare',
    'dim_infrastructure.csv': 'dim_infrastructure',
    'dim_location.csv': 'dim_location',
    'dim_prevention.csv': 'dim_prevention',
    'dim_socioeconomic.csv': 'dim_socioeconomic',
    'dim_weather.csv': 'dim_weather',
    'fact_malaria_cases.csv': 'fact_malaria_cases'
}


def main():
    db_connection = get_db_connection()
    try:
        for file_name, table_name in csv_files.items():
            load_csv_to_db(file_name, table_name, db_connection=db_connection)
    finally:
        db_connection.close()


if __name__ == "__main__":
    main()