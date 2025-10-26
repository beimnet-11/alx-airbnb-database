# Airbnb Database Schema

This folder contains the SQL scripts to define the Airbnb-style database schema.

## Files

- `schema.sql` – Contains `CREATE TABLE` statements for all entities:
  - Users
  - Properties
  - Bookings
  - Reviews
  - Payments
- `README.md` – This documentation.

## Purpose

The `schema.sql` script creates tables with:
- Primary keys and foreign keys
- Constraints (e.g., `NOT NULL`, `UNIQUE`, `CHECK`)
- Indexes for optimal query performance

This ensures a robust structure for storing users, listings, bookings, reviews, and payments.

## How to Use

1. Ensure PostgreSQL (or your database engine) is running.  
2. Execute the script to create the schema:

```bash
psql -U <username> -d <database_name> -f schema.sql




