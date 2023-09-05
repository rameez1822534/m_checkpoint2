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

def insert_translation(word, translation):
    dbconn = db_connection()
    cur = dbconn.cursor()
    try:
        
        cur.execute("INSERT INTO dictionary (word, translation) VALUES (%s, %s);", (word, translation))
        dbconn.commit()
        cur.close()
        dbconn.close()
        print("Translation added successfully.")
    except Exception as e:
        dbconn.rollback()
        cur.close()
        dbconn.close()
        print(f"Error inserting translation: {e}")

while True:
    cmd = input("Command (list, add, delete, quit): ").strip().lower()
    
    if cmd == "quit":
        break
    elif cmd == "list":
        word_list = read_dict()
        for word in word_list:
            print(f"ID: {word[0]}, Word: {word[1]}, Translation: {word[2]}")
    elif cmd == "add":
        new_word = input("Enter the new word: ")
        new_translation = input("Enter the translation: ")
        insert_translation(new_word, new_translation)
    elif cmd == "delete":
        word_id = input("Enter the ID of the word to delete: ")
        
        dbconn = db_connection()
        cur = dbconn.cursor()
        cur.execute("DELETE FROM dictionary WHERE id = %s;", (word_id,))
        dbconn.commit()
        cur.close()
        dbconn.close()
        print("Word deleted successfully.")
    else:
        print("Invalid command. Please use 'list', 'add', 'delete', or 'quit'.")

