import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

def getConnection() :
    conn = psycopg2.connect(database=os.getenv("DB_NAME"),
                            user=os.getenv("DB_USER"),
                            password=os.getenv("DB_PASS"),
                            host=os.getenv("DB_HOST"),
                            port=os.getenv("DB_PORT"))
    print("Database connected successfully")
    return conn