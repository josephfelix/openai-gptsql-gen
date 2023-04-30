import openai
import os
import mysql.connector
from mysql.connector import Error
import numpy as np

# Set up OpenAI API key
openai.api_key = os.getenv("OPENAI_API_KEY")

# Connect to the MySQL database
def create_connection(host, user, password, database):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=host,
            user=user,
            passwd=password,
            database=database
        )
        print("Connection to MySQL DB successful")
    except Error as e:
        print(f"The error '{e}' occurred")
    return connection

# Fetch all comments from the table
def fetch_columns(connection):
    cursor = connection.cursor()
    query = """
SELECT
    t.TABLE_NAME AS table_name,
    c.COLUMN_NAME AS column_name,
    c.COLUMN_COMMENT AS comment
FROM 
    INFORMATION_SCHEMA.TABLES t 

INNER JOIN INFORMATION_SCHEMA.COLUMNS c 
        ON t.TABLE_NAME = c.TABLE_NAME 
            AND t.TABLE_SCHEMA = c.TABLE_SCHEMA
WHERE
    c.COLUMN_COMMENT <> ''
    AND t.TABLE_SCHEMA = 'dbreport_test' 
    AND t.TABLE_NAME = 'users';"""
    cursor.execute(query)
    columns = cursor.fetchall()
    return columns

# Add embedings to embedding table
def insert_embedding(connection, table_name, column_name, embedding):
    cursor = connection.cursor()
    query = """
      INSERT INTO embeddings (
        table_name, column_name, embedding, 
        created_at, updated_at, deleted_at) 
        VALUES (%s, %s, %s, NOW(), NOW(), NULL)
    """
    cursor.execute(query, (table_name, column_name, str(embedding.tolist())))
    connection.commit()

# Generate embeddings using the text-embedding-ada-002 model
def generate_embedding(prompt):
    try:
        response = openai.Embedding.create(
          input=prompt,
          model="text-embedding-ada-002"
        )
        return np.array(response.data[0].embedding)
    except Exception as e:
        print(f"Error generating embedding: {e}")
        return None

# Main script
if __name__ == "__main__":
    connection = create_connection(
      host="database",
      user="root",
      password="dbreport",
      database="dbreport_test"
    )
    
    if connection:
        columns = fetch_columns(connection)
        for column in columns:
            table_name, column_name, comment = column
            embedding = generate_embedding(comment)
            insert_embedding(connection, table_name, column_name, embedding)
            print(f"Added embedding for table {table_name} column {column_name}")

        # Close the connection
        connection.close()