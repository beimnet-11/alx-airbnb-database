# SQL Joins Queries

This directory contains SQL queries demonstrating different types of joins for the Airbnb database.

## Files

- `joins_queries.sql` - Contains three complex join queries

## Queries Description

### 1. INNER JOIN
**Objective**: Retrieve all bookings and the respective users who made those bookings.
- Joins the `bookings` and `users` tables
- Returns only records where there's a match in both tables
- Useful for finding bookings that have associated users

### 2. LEFT JOIN  
**Objective**: Retrieve all properties and their reviews, including properties that have no reviews.
- Joins the `properties` and `reviews` tables
- Returns all properties regardless of whether they have reviews
- Properties without reviews will have NULL values in review columns

### 3. FULL OUTER JOIN
**Objective**: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
- Uses UNION of LEFT JOIN and RIGHT JOIN to simulate FULL OUTER JOIN (for MySQL)
- Returns all users and all bookings in a single result set
- Users without bookings will have NULL values in booking columns
- Bookings without users will have NULL values in user columns

## Database Schema Assumptions

The queries assume the following tables exist:
- `users` (user_id, username, email, ...)
- `bookings` (booking_id, user_id, check_in_date, check_out_date, total_price, ...)
- `properties` (property_id, property_name, description, ...)
- `reviews` (review_id, property_id, rating, comment, created_at, ...)

## Usage

Run the queries in your SQL database management tool. Make sure to adjust table and column names if your actual schema differs.
