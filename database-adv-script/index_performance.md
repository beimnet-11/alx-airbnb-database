# Database Index Performance Analysis

## Objective
Identify and create indexes to improve query performance for high-usage columns in the Airbnb database.

## High-Usage Columns Identified

### Users Table
- `id` (Primary key, JOIN operations)
- `email` (Authentication, WHERE clauses)
- `name` (Search operations)

### Properties Table
- `id` (Primary key, JOIN operations)
- `city`, `country` (Location-based searches)
- `price` (Range queries, filtering)
- `property_type` (Category filtering)
- `is_active` (Status filtering)

### Bookings Table
- `id` (Primary key)
- `user_id` (Foreign key, JOIN with users)
- `property_id` (Foreign key, JOIN with properties)
- `start_date`, `end_date` (Date range queries, availability checks)
- `status` (Booking status filtering)

## Index Creation Strategy

### Single Column Indexes
Created for columns frequently used in:
- WHERE clauses
- JOIN conditions
- ORDER BY clauses

### Composite Indexes
Created for common query patterns:
- User searches by email and name
- Property searches by location, type, and price
- Booking queries by user and date ranges

## Performance Measurement

### Example Query 1: User Booking History
```sql
-- Before indexes
EXPLAIN ANALYZE
SELECT u.name, b.start_date, b.end_date 
FROM users u
JOIN bookings b ON u.id = b.user_id
WHERE u.email = 'user@example.com'
ORDER BY b.start_date DESC;
