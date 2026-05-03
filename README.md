# Project Title

## ⚙️ AIRFLOW — Automated Daily Orchestration

![Airflow Dashboard](docs/images/airflow_dashboard.png)

### DAG Details
- **DAG Name**: daily_orchestration
- **Schedule**: Daily at 07:00 AM UTC

## Tech Stack
| Technology   | Description                   | Version | 
|--------------|-------------------------------|---------|
| DBT          | Data Build Tool              | 1.0     |
| METABASE     | Business Intelligence Tool    | 0.40.0  |
| ⚙️ Apache Airflow | Pipeline orchestration       | 3.2     |

## Quick Start
### Setting Up Airflow
1. Clone the repository.
2. Run the following command to start Airflow using Docker:
   ```bash
   docker-compose up -d
   ```
3. Access the Airflow UI at http://localhost:8080.

### DAG Visualization
- Navigate to the **DAGs** tab in the Airflow UI to view your DAGs.
