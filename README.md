# dbt-duckdb-tickit-pipeline
Seamless data engineering workflow using dbt with DuckDB for the TickitDB schema, focusing on local data lake development and robust data practices.

![Data Lineage](/dbt-duckdb-tickit-pipeline.png)

# Introduction

This project is a dedicated adaptation for DuckDB, building on Gary A. Stafford's original dbt-redshift-demo. Utilizing the TickitDB data model from AWS RedShift, it is designed for comprehensive local data lake development, covering stages from raw data management to staging, integration, and mart creation, extending to reporting and business visualization. The workflow places strong emphasis on data quality, comprehensive data lineage tracking, and business metadata management. For a more detailed conceptual exploration, refer to Gary A. Stafford's insightful article, ["Lakehouse Data Modeling using dbt, Amazon Redshift, Redshift Spectrum, and AWS Glue."](https://garystafford.medium.com/lakehouse-data-modeling-using-dbt-amazon-redshift-redshift-spectrum-and-aws-glue-fdc5629c3df8)

## Getting Started with dbt / DuckDB Project

### Setting Up Your Python Environment

Create and activate a Python virtual environment:

```bash
python3 -m venv env 
source env/bin/activate
```

### Installing dbt

Install dbt and verify the installation with the following commands:

```bash
pip install -r requirements.txt  
dbt --version
pip freeze > requirements.txt
```

**Optional**: To use PostgreSQL instead of DuckDB, upgrade your dbt installation for PostgreSQL compatibility:

```bash
pip install --upgrade dbt-postgres
```

### Install dbt Dependencies/Packages

```bash
dbt deps        # Install dbt dependencies
```

### Configuring the Data Sources

`profiles.yml` configuration details:

```yaml
sporting_event_sales_db:
  target: dev  # Default target environment
  outputs:
    dev:
      type: duckdb  # Adapter type for DuckDB
      path: 'sporting_event_sales_db.duckdb'  # Path to your DuckDB file
      schema: raw  # Default schema name for development
      threads: 24  # Number of threads dbt will use during execution
    prod:
      type: postgres  # Adapter type for PostgreSQL
      threads: 10  # Number of threads dbt will use in production
      host: '<your_production_host>'  # Hostname or IP of the PostgreSQL server
      port: 5432  # Port number where PostgreSQL is accessible
      user: '<your_username>'  # Username for PostgreSQL
      pass: '<your_password>'  # Password for PostgreSQL
      dbname: 'sporting_event_sales_db'  # Database name
      schema: raw  # Default schema name for production
```

### Configuring the `dbt_project.yml`

Refer to the `dbt_project.yml` for specific project configurations.

### Testing the Configuration:

```bash
dbt debug  # Runs a series of tests to verify connectivity to your configured profiles
```

# Load initial data from pipe-delimited CSV seed files

```
dbt seed
```

### Running the Pipeline:

```bash
dbt run         # Run your dbt models
dbt test        # Execute tests to verify model integrity
```

### Documentation and Lineage Visualization

Generate and visualize documentation and data lineage to aid in understanding the flow and dependencies of your data:

```bash
dbt docs generate
dbt docs serve
```

### Optional: Integration with Open Lineage

Though the dbt-duckdb adapter does not support Open Lineage directly, set up environment variables for integration and push lineage events to a Marquez server:

```bash
export OPENLINEAGE_NAMESPACE=sporting_event_sales_db
export OPENLINEAGE_URL=http://[ip_address]:[port]
dbt-ol run  # Run dbt with Open Lineage collection
```

**Note**: Replace `[ip_address]` and `[port]` with the actual IP address and port number of your Marquez server.

### Elementary Data Observability

```
pip install elementary-data  
pip install 'elementary-data[duckdb]'  
pip install 'elementary-data[postgres]' 
dbt run --select elementary 
dbt test  --select elementary   
edr --help   
edr report   
```     