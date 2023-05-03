# GPT SQL Query Generator

This is simple python application to generate SQL Database queries using GPT-3 from OpenAI.

## How it works:

1. Getting SQL schemas from MySQL and compile prompt from SQL Schema
2. Wait for user input
3. Generate SQL query from prompt + user input
4. Show SQL query and ask user to confirm or edit if it is correct before executing it
5. Execute SQL query and show results in a table

## Environment

- DATABASE_HOST: MySQL database URL
- DATABASE_PORT: MySQL database port
- DATABASE_USER: MySQL database user
- DATABASE_PASS: MySQL database password
- DATABASE_DB: MySQL database name
- OPENAI_TOKEN: OpenAI API token (Not nessessary, you can set it in the UI)
- APP_PORT: Port to run the application (default: 5000)
- OPENAI_ENGINE: OpenAI engine to use (default: text-davinci-003, not nessessary). You can set some free to use model: text-chat-davinci-002-20221122
- DEBUG_MODE: Activate the debug mode or note. It also enables Flask hot reloading

## How to run

1. Set environment variables in `.env` file in project root or in your system
2. Run the application using `make run` and open `http://localhost:5000` in your browser
