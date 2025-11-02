# SQL Aggregations and Window Functions

This directory contains SQL queries demonstrating aggregation functions and window functions for data analysis.

## Files

- `aggregations_and_window_functions.sql` - Contains aggregation and window function examples

## Queries Description

### 1. Aggregation with GROUP BY
**Objective**: Find the total number of bookings made by each user

**Approach**:
- Uses `COUNT()` aggregation function with `GROUP BY` clause
- Two versions: 
  - LEFT JOIN to include all users (even those with zero bookings)
  - INNER JOIN to include only users with at least one booking
- Results ordered by booking count in descending order

**Key Features**:
- Demonstrates basic aggregation with GROUP BY
- Shows difference between LEFT JOIN and INNER JOIN in aggregation contexts

### 2. Window Functions
**Objective**: Rank properties based on total number of bookings received

**Approach**:
- Uses window functions (`ROW_NUMBER`, `RANK`, `DENSE_RANK`) to assign rankings
- Each function handles ties differently:
  - `ROW_NUMBER()`: Unique sequential numbers, no ties
  - `RANK()`: Same rank for ties, gaps in sequence
  - `DENSE_RANK()`: Same rank for ties, no gaps in sequence
- Includes example with `PARTITION BY` for ranking within categories

**Key Features**:
- Window functions operate over a set of rows without collapsing them
- Maintain individual row identity while performing calculations across rows
- `OVER()` clause defines the window for the function

## Function Comparison

| Function | Ties Handling | Sequence | Example Output |
|----------|---------------|----------|----------------|
| ROW_NUMBER | No ties | 1,2,3,4 | 1,2,3,4 |
| RANK | Same rank, gaps | 1,2,2,4 | 1,2,2,4 |
| DENSE_RANK | Same rank, no gaps | 1,2,2,3 | 1,2,2,3 |

## Database Schema
The queries assume the following tables:
- `users` (id, email, name)
- `properties` (id, title, description, property_type) 
- `bookings` (id, user_id, property_id, start_date, end_date)
