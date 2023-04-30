# DB Report Generator

## How to run
```bash
make dev
```

## Connect to MySQL database to get embeddings
```bash
make database
```

After connecting to the database, you can run the following query to get the embeddings:
```sql
SELECT * FROM embeddings\G
```

## Generate embeddings
Connect to the database and run the following query:
```sql
TRUNCATE TABLE embeddings;
```

Then run the following command:
```bash
make embedding
```