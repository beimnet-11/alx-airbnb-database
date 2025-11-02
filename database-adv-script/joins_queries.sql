-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_price,
    u.user_id,
    u.username,
    u.email
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.user_id;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties with no reviews
SELECT 
    p.property_id,
    p.property_name,
    p.description,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at
FROM 
    properties p
LEFT JOIN 
    reviews r ON p.property_id = r.property_id;

-- 3. FULL OUTER JOIN: Retrieve all users and all bookings, even if user has no booking or booking is not linked to a user
-- Note: MySQL doesn't support FULL OUTER JOIN directly, so we use UNION of LEFT and RIGHT JOIN
SELECT 
    u.user_id,
    u.username,
    u.email,
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_price
FROM 
    users u
LEFT JOIN 
    bookings b ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    u.username,
    u.email,
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_price
FROM 
    users u
RIGHT JOIN 
    bookings b ON u.user_id = b.user_id;

-- Alternative using FULL OUTER JOIN (for databases that support it like PostgreSQL):
/*
SELECT 
    u.user_id,
    u.username,
    u.email,
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_price
FROM 
    users u
FULL OUTER JOIN 
    bookings b ON u.user_id = b.user_id;
*/
