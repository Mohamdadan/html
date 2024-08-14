#!/bin/bash


# Variables
PG_HOST="localhost"                # Change this to your PostgreSQL server host
PG_PORT="5432"                     # Change this to your PostgreSQL server port
PG_USER="postgres"                # Change this to your PostgreSQL user
PG_DB="postgres"                  # Change this to the database you are connecting to
PROMOTE_LOG="/var/log/postgresql/promote.log"

# Function to check if PostgreSQL is running
check_postgres() {
    if systemctl is-active --quiet postgresql; then
        echo "PostgreSQL is running."
    else
        echo "PostgreSQL is not running. Exiting."
        exit 1
    fi
}

# Function to promote standby to primary
promote_standby() {
    echo "Promoting standby to primary..."

    # Execute the pg_promote function using psql
    PSQL_COMMAND="SELECT pg_promote();"
    echo $PSQL_COMMAND | psql -h $PG_HOST -p $PG_PORT -U $PG_USER -d $PG_DB >> $PROMOTE_LOG 2>&1

    if [ $? -eq 0 ]; then
        echo "Promotion successful."
        echo "$(date): Standby promoted to primary" >> $PROMOTE_LOG
    else
        echo "Promotion failed."
        echo "$(date): Promotion failed" >> $PROMOTE_LOG
        exit 1
    fi
}

# Check PostgreSQL service status
check_postgres

# Promote standby to primary
promote_standby

# Restart PostgreSQL service
echo "Restarting PostgreSQL service..."
systemctl restart postgresql

if [ $? -eq 0 ]; then
    echo "PostgreSQL service restarted successfully."
else
    echo "Failed to restart PostgreSQL service."
    exit 1
fi

echo "Promotion process completed."
