from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'ganga',
    'retries': 2,
    'retry_delay': timedelta(minutes=5),
    'email_on_failure': False,
}

with DAG(
    dag_id='warehouse_pipeline',
    default_args=default_args,
    description='Daily warehouse pipeline: dbt staging > intermediate > marts > test',
    schedule='0 6 * * *',          # ← FIXED: was schedule_interval
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=['warehouse', 'dbt', 'sql-server'],
) as dag:

    check_sources = BashOperator(
        task_id='check_source_files',
        bash_command='echo "Pipeline started - checking environment..."',
    )

    dbt_staging = BashOperator(
        task_id='dbt_run_staging',
        bash_command='echo "Running staging models..." && echo "dbt run --select staging"',
    )

    dbt_intermediate = BashOperator(
        task_id='dbt_run_intermediate',
        bash_command='echo "Running intermediate models..." && echo "dbt run --select intermediate"',
    )

    dbt_marts = BashOperator(
        task_id='dbt_run_marts',
        bash_command='echo "Running mart models..." && echo "dbt run --select marts"',
    )

    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command='echo "Running data quality tests..." && echo "dbt test"',
    )

    dbt_docs = BashOperator(
        task_id='dbt_generate_docs',
        bash_command='echo "Generating documentation..." && echo "dbt docs generate"',
    )

    # Pipeline order — each task waits for the previous one
    check_sources >> dbt_staging >> dbt_intermediate >> dbt_marts >> dbt_test >> dbt_docs