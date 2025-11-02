-- 1. Aggregation with GROUP BY: Find total number of bookings made by each user
SELECT 
    u.id AS user_id,
    u.email,
    u.name,
    COUNT(b.id) AS total_bookings
FROM 
    users u
LEFT JOIN 
    bookings b ON u.id = b.user_id
GROUP BY 
    u.id, u.email, u.name
ORDER BY 
    total_bookings DESC;

-- Alternative with only users who have bookings (using INNER JOIN)
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
ORDER BY 
    total_bookings DESC;

-- 2. Window Functions: Rank properties based on total number of bookings received

-- Using ROW_NUMBER() - assigns unique sequential numbers
SELECT 
    p.id AS property_id,
    p.title,
    p.description,
    COUNT(b.id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.id) DESC) AS booking_rank
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.id = b.property_id
GROUP BY 
    p.id, p.title, p.description
ORDER BY 
    total_bookings DESC;

-- Using RANK() - handles ties with same rank, gaps in sequence
SELECT 
    p.id AS property_id,
    p.title,
    p.description,
    COUNT(b.id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.id) DESC) AS booking_rank
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.id = b.property_id
GROUP BY 
    p.id, p.title, p.description
ORDER BY 
    total_bookings DESC;

-- Using DENSE_RANK() - handles ties with same rank, no gaps in sequence
SELECT 
    p.id AS property_id,
    p.title,
    p.description,
    COUNT(b.id) AS total_bookings,
    DENSE_RANK() OVER (ORDER BY COUNT(b.id) DESC) AS booking_rank
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.id = b.property_id
GROUP BY 
    p.id, p.title, p.description
ORDER BY 
    total_bookings DESC;

-- Additional example: Partition by property type (if available) and rank within each type
-- Assuming there's a property_type column
/*
SELECT 
    p.id AS property_id,
    p.title,
    p.property_type,
    COUNT(b.id) AS total_bookings,
    RANK() OVER (PARTITION BY p.property_type ORDER BY COUNT(b.id) DESC) AS rank_in_category
FROM 
    properties p
LEFT JOIN 
    bookings b ON p.id = b.property_id
GROUP BY 
    p.id, p.title, p.property_type
ORDER BY 
    p.property_type, total_bookings DESC;
*/
