# Postgres-notes

SQL language is categorized into 5 categories:

1. **DDL** (Data Definition Language): Define the database schema and modify the structure of database objects in the database
    - CREATE: create database or its objects (table, index, store procedure, trigger, view, function)
    - ALTER: alter the structure of database
    - DROP: delete objects of database
    - TRUNCATE: remove all records from a table

2. **DML** (Data Manipulation Language): Used for manipulate data present in database
    - INSERT:
    - UPDATE:
    - DELETE:

3. **DQL** (Data Query Language): Used for retrieve data from database
    - SELECT:

4. **DTL** (Data Transaction Language): Deal with transaction within database. It is part of ACID properties of RDBMS
    - COMMIT:
    - ROLLBACK:
    - SAVEPOINT:

5. **DCL** (Data Control Lanaguage): Deal with authentication
    - GRANT: give user's access priviledge to database
    - REVOKE: withdraw user's access priviledge


## Database transaction properties
A transaction is a sequence of database operations that satisfy the ACID properties. These four properties are to ensure the database reliability in the situation of system error, power failure or software crash and it has influenced many aspects the development of database system.

- **Atomicity**: a transaction is completely succeeded or failed. Each transaction is treated as a single unit.

- **Consistency**: a transaction has to maintain the data validation before writing into database. Data must be valid according to all defined rules including constraint, default, cascades, trigger, etc.

- **Isolation**: ensure the execution of mutiple transaction to leave the database in a state that would have been obtained if the transactions are executed in sequencelly. It is the main goal of concurrency control.

- **Durability**: a transaction after committed will be remain eventhough the system gets failure. This usually means that the complete transaction is recorded into non-volatile memory.


## Conncurency phenomena
### Lost update
Two transactions update same value. (not occur in most database engines)


### Dirty read
One transaction update one value then rollback. In between of this transaction, another transaction read the value. (this is not happening on Postgres)


### Non-repeatable read
On transaction read 2 times, but during operation another transaction update the value. Then the read commands return 2 different values.

### Phantom row
One transaction read a set of rows 2 time, but during operation another transaction insert new value. Then there is a phantom row appears in the 2nd read.

## [Posgres Isolation Level](https://www.postgresql.org/docs/9.5/transaction-iso.html)
- **Read uncommited**: see data at the time of query execution (even other transaction not committed)
- **Read commited**: see data before the query began
- **Repeatable read**: see data before the transaction began
- **Serializable**: 