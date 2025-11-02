-- Initial Complex Query (Before Optimization)
SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_created,
    
    u.id AS user_id,
    u.email AS user_email,
    u.name AS user_name,
    u.phone_number AS user_phone,
    
    p.id AS property_id,
    p.title AS property_title,
    p.description AS property_description,
    p.price_per_night,
    p.property_type,
    p.city,
    p.country,
    
    pay.id AS payment_id,
    pay.amount AS payment_amount,
    pay.payment_method,
    pay.status AS payment_status,
    pay.created_at AS payment_date,
    
    -- Additional joins for comprehensive data
    r.rating AS property_rating,
    r.comment AS review_comment
    
FROM bookings b
LEFT JOIN users u ON b.user_id = u.id
LEFT JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
LEFT JOIN reviews r ON b.id = r.booking_id
WHERE b.start_date >= '2024-01-01'
ORDER BY b.created_at DESC
LIMIT 1000;

-- Optimized Query (After Refactoring)
-- Strategy: Reduce unnecessary joins, use selective columns, leverage indexes
SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_created,
    
    u.id AS user_id,
    u.email AS user_email,
    u.name AS user_name,
    
    p.id AS property_id,
    p.title AS property_title,
    p.price_per_night,
    p.property_type,
    p.city,
    
    pay.amount AS payment_amount,
    pay.payment_method,
    pay.status AS payment_status
    
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
WHERE b.start_date >= '2024-01-01'
  AND b.status IN ('confirmed', 'completed')
ORDER BY b.created_at DESC
LIMIT 100;

-- Further optimized with CTE for better readability and potential performance
WITH recent_bookings AS (
    SELECT 
        id,
        user_id,
        property_id,
        start_date,
        end_date,
        total_price,
        status,
        created_at
    FROM bookings
    WHERE start_date >= '2024-01-01'
      AND status IN ('confirmed', 'completed')
    ORDER BY created_at DESC
    LIMIT 100
)
SELECT 
    rb.id AS booking_id,
    rb.start_date,
    rb.end_date,
    rb.total_price,
    rb.status AS booking_status,
    rb.created_at AS booking_created,
    
    u.email AS user_email,
    u.name AS user_name,
    
    p.title AS property_title,
    p.property_type,
    p.city,
    
    pay.amount AS payment_amount,
    pay.payment_method
    
FROM recent_bookings rb
INNER JOIN users u ON rb.user_id = u.id
INNER JOIN properties p ON rb.property_id = p.id
LEFT JOIN payments pay ON rb.id = pay.booking_id
ORDER BY rb.created_at DESC;

-- Index recommendations to support the optimized queries
CREATE INDEX IF NOT EXISTS idx_bookings_start_date_status ON bookings(start_date, status);
CREATE INDEX IF NOT EXISTS idx_bookings_created_desc ON bookings(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_payments_booking_id ON payments(booking_id);
