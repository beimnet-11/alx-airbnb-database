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
