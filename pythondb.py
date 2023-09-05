import psycopg2

def db_connection():
    return psycopg2.connect(
        host="localhost"
)
