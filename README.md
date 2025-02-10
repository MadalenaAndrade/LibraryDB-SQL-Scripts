# SQL Library Database

This is a **personal learning project** where I practiced SQL by designing a **fictional library database** in SQL Server.  
It includes scripts for **creating tables, inserting sample data, and running queries** to explore and analyze the data.

## 📂 Project Structure

- [`/diagrams/`](https://github.com/MadalenaAndrade/LibraryDB-SQL-Scripts/tree/main/diagrams) -> Database schemas
- [`/queries/procedures`](https://github.com/MadalenaAndrade/LibraryDB-SQL-Scripts/tree/main/queries/Procedures) -> Stored procedures 
- [`/queries/SelectQueries/`](https://github.com/MadalenaAndrade/LibraryDB-SQL-Scripts/tree/main/queries/SelectQueries) -> Queries to retrieve data and insights
- [`/queries/views`](https://github.com/MadalenaAndrade/LibraryDB-SQL-Scripts/tree/main/queries/Views)-> SQL views used for Select Queries
- [`FullLibraryQuery.sql`](https://github.com/MadalenaAndrade/LibraryDB-SQL-Scripts/blob/main/FullLibraryQuery.sql) -> Full script related to the creation of tables, relationships, and data population
- [`README.md`](https://github.com/MadalenaAndrade/LibraryDB-SQL-Scripts/blob/main/README.md) -> Project documentation


## 🚀 About This Project
- This project was created **to help me learn SQL**.
- The database simulates a **library system**, including books, clients, rentals, and overdue tracking.
- **Some queries and procedures might not be fully optimized**, as they were part of my learning process.

## ⚠️ Important Note
- **Foreign key constraints with cascade effects (delete/update) were applied directly in SSMS** and are **not explicitly defined in the SQL scripts**.
- If you run these scripts, you may need to manually define cascade constraints. 

## 🛠️ How to Use
1. **Run** [`FullLibraryQuery.sql`](https://github.com/MadalenaAndrade/LibraryDB-SQL-Scripts/blob/main/FullLibraryQuery.sql) to create the database and populate it with sample data.
2. **Test the queries** inside [`/queries/SelectQueries/`](https://github.com/MadalenaAndrade/LibraryDB-SQL-Scripts/tree/main/queries/SelectQueries) to explore different ways of retrieving data.
3. **Feel free to check or improve the procedures**, some of them might need adjustments.

This is not a perfect project, but it helped me improve my SQL skills!  
If anyone finds it useful, feel free to explore it. 😊
