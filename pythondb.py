import psycopg2

def db_connection():
    try:
        # Attempt to establish a connection to the database
        conn = psycopg2.connect(
            host="localhost",
            port="5432",  # Usually port number 5432 for PostgreSQL
            database="phonedb",
            user="postgres",
            password="18@Rameez22"  # Replace with your own password
        )
        return conn
    except Exception as e:
        print(f"Database connection error: {e}")
        return None

def read_dict():    
    dbconn = db_connection()
cur = dbconn.cursor()
cur.execute("SELECT id, word, translation FROM dictionary;")
rows = cur.fetchall()
cur.close()
dbconn.close()
return rows

while True: ## REPL - Read Execute Program Loop
    cmd = input("Command: ")
if cmd == "quit":
    exit()
