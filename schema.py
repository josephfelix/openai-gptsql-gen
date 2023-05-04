"""Generate SQL Schema from MySQL"""
import os
import sys
from dotenv import load_dotenv
import mysql.connector
from mysql.connector import Error

# Read .env file
load_dotenv()

DATABASE_HOST = os.getenv('DATABASE_HOST')
DATABASE_PORT = os.getenv('DATABASE_PORT')
DATABASE_USER = os.getenv('DATABASE_USER')
DATABASE_PASS = os.getenv('DATABASE_PASS')
DATABASE_DB = os.getenv('DATABASE_DB')

class Schema:
    """Generate SQL Schema from MySQL"""

    def __init__(self, schema = DATABASE_DB):
        """Connect to MySQL database"""
        self.schema = schema
        try:
            self.conn = mysql.connector.connect(
                host=DATABASE_HOST,
                user=DATABASE_USER,
                passwd=DATABASE_PASS,
                database=DATABASE_DB
            )
        except Error as err:
            print(f'Unable to connect!\n{err}')
            sys.exit(1)
        else:
            print('Connected to MySQL database successfully.')
        self.cur = self.conn.cursor()
        self.comments = []
        self.tables = []
        self.columns = []

    def get_tables(self):
        """Get list of tables"""
        self.cur.execute("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = %s", (self.schema,))
        tables = self.cur.fetchall()
        self.tables = tables
        return tables

    def get_all_comments(self):
        """Get list of all comments"""
        self.cur.execute("""
SELECT
    t.TABLE_SCHEMA AS table_schema,
    t.TABLE_NAME AS table_name,
    c.COLUMN_NAME AS column_name,
    c.COLUMN_COMMENT AS description
FROM 
    INFORMATION_SCHEMA.TABLES t 

INNER JOIN INFORMATION_SCHEMA.COLUMNS c 
        ON t.TABLE_NAME = c.TABLE_NAME 
            AND t.TABLE_SCHEMA = c.TABLE_SCHEMA
WHERE
    c.COLUMN_COMMENT <> ''
    AND t.TABLE_SCHEMA NOT IN ('performance_schema', 'mysql');""")
        comments = self.cur.fetchall()
        self.comments = comments
        return comments

    def get_columns(self, table):
        """Get list of columns for a table"""
        self.cur.execute("SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = %s AND TABLE_NAME = %s", (self.schema, table))
        columns = self.cur.fetchall()
        return columns

    def regen(self, selected):
        """Regenerate SQL Schema only for selected tables"""
        if len(selected) == 0:
            return 'No tables selected.'
        prompt = ''
        tables = self.tables
        comments = self.comments
        for table in tables:
            if table[0] in selected:
                columns = self.get_columns(table[0])
                prompt += f'The "{table[0]}" table has columns: '
                for column in columns:
                    cmnt = ''
                    for comment in comments:
                        if comment[0] == self.schema and comment[1] == table[0] and comment[2] == column[0]:
                            cmnt = comment[3]
                            break
                    if cmnt == '':
                        prompt += f'{column[0]} ({column[1]}), '
                    else:
                        prompt += f'{column[0]} ({column[1]} - {cmnt}), '
                prompt = prompt[:-2] + '. '
        return prompt

    def index(self):
        """Generate SQL Schema"""
        prompt = ''
        json_data = {}
        tables = self.get_tables()
        comments = self.get_all_comments()

        for table in tables:
            columns = self.get_columns(table[0])
            prompt += f'The "{table[0]}" table has columns: '
            json_data[table[0]] = []
            for column in columns:
                cmnt = ''
                for comment in comments:
                    if comment[0] == self.schema and comment[1] == table[0] and comment[2] == column[0]:
                        cmnt = comment[3]
                        break
                if cmnt == '':
                    prompt += f'{column[0]} ({column[1]}), '
                else:
                    prompt += f'{column[0]} ({column[1]} - {cmnt}), '
                json_data[table[0]].append({
                    'name': column[0],
                    'type': column[1],
                    'comment': cmnt,
                    "seleted": True
                })
            prompt = prompt[:-2] + '. '
        return prompt, json_data
