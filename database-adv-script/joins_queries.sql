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
-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    u.id AS user_id,
    u.email,
    u.name
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.id;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews
SELECT 
    p.id AS property_id,
    p.title,
    p.description,
    r.id AS review_id,
    r.rating,
    r.comment
FROM 
    properties p
LEFT JOIN 
    reviews r ON p.id = r.property_id;

-- 3. FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
-- Using UNION to simulate FULL OUTER JOIN in MySQL
SELECT 
    u.id AS user_id,
    u.email,
    u.name,
    b.id AS booking_id,
    b.start_date,
    b.end_date
FROM 
    users u
LEFT JOIN 
    bookings b ON u.id = b.user_id

UNION

SELECT 
    u.id AS user_id,
    u.email,
    u.name,
    b.id AS booking_id,
    b.start_date,
    b.end_date
FROM 
    users u
RIGHT JOIN 
    bookings b ON u.id = b.user_id;
-- 1. Non-correlated subquery: Find all properties where the average rating is greater than 4.0
SELECT 
    p.id AS property_id,
    p.title,
    p.description,
    (SELECT AVG(r.rating) FROM reviews r WHERE r.property_id = p.id) AS average_rating
FROM 
    properties p
WHERE 
    (SELECT AVG(r.rating) FROM reviews r WHERE r.property_id = p.id) > 4.0;

-- Alternative non-correlated subquery using HAVING with JOIN
SELECT 
    p.id AS property_id,
    p.title,
    p.description,
    AVG(r.rating) AS average_rating
FROM 
    properties p
JOIN 
    reviews r ON p.id = r.property_id
GROUP BY 
    p.id, p.title, p.description
HAVING 
    AVG(r.rating) > 4.0;

-- 2. Correlated subquery: Find users who have made more than 3 bookings
SELECT 
    u.id AS user_id,
    u.email,
    u.name,
    (SELECT COUNT(*) FROM bookings b WHERE b.user_id = u.id) AS total_bookings
FROM 
    users u
WHERE 
    (SELECT COUNT(*) FROM bookings b WHERE b.user_id = u.id) > 3;

-- Alternative using JOIN and GROUP BY (non-correlated approach)
SELECT 
    u.id AS user_id,
    u.email,
    u.name,
    COUNT(b.id) AS total_bookings
FROM 
    users u
JOIN 
    bookings b ON u.id = b.user_id
GROUP BY 
    u.id, u.email, u.name
HAVING 
    COUNT(b.id) > 3;
