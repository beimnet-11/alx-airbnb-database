-- Indexes for Users table
-- Index on primary key (usually automatically created, but shown for completeness)
CREATE INDEX IF NOT EXISTS idx_users_id ON users(id);

-- Index for email (commonly used for authentication and lookups)
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Index for name (used in search and filtering)
CREATE INDEX IF NOT EXISTS idx_users_name ON users(name);

-- Composite index for common query patterns
CREATE INDEX IF NOT EXISTS idx_users_email_name ON users(email, name);

-- Indexes for Properties table
-- Index on primary key
CREATE INDEX IF NOT EXISTS idx_properties_id ON properties(id);

-- Index for location-based queries (if location columns exist)
CREATE INDEX IF NOT EXISTS idx_properties_city ON properties(city);
CREATE INDEX IF NOT EXISTS idx_properties_country ON properties(country);

-- Index for price range queries
CREATE INDEX IF NOT EXISTS idx_properties_price ON properties(price);

-- Index for property type filtering
CREATE INDEX IF NOT EXISTS idx_properties_type ON properties(property_type);

-- Index for availability and active status
CREATE INDEX IF NOT EXISTS idx_properties_status ON properties(is_active);

-- Composite index for common search patterns
CREATE INDEX IF NOT EXISTS idx_properties_search ON properties(city, property_type, price);

-- Indexes for Bookings table
-- Index on primary key
CREATE INDEX IF NOT EXISTS idx_bookings_id ON bookings(id);

-- Foreign key indexes for JOIN operations
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);

-- Indexes for date range queries (very important for booking systems)
CREATE INDEX IF NOT EXISTS idx_bookings_dates ON bookings(start_date, end_date);

-- Index for status filtering
CREATE INDEX IF NOT EXISTS idx_bookings_status ON bookings(status);

-- Composite index for user booking history queries
CREATE INDEX IF NOT EXISTS idx_bookings_user_dates ON bookings(user_id, start_date DESC);

-- Indexes for Reviews table (if not already covered)
CREATE INDEX IF NOT EXISTS idx_reviews_property_id ON reviews(property_id);
CREATE INDEX IF NOT EXISTS idx_reviews_rating ON reviews(rating);
CREATE INDEX IF NOT EXISTS idx_reviews_created_at ON reviews(created_at);

-- Composite index for property rating analysis
CREATE INDEX IF NOT EXISTS idx_reviews_property_rating ON reviews(property_id, rating);

-- Drop indexes if needed (commented out for safety)
-- DROP INDEX IF EXISTS idx_users_email;
-- DROP INDEX IF EXISTS idx_bookings_dates;
