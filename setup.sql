-- SWAPIT Database Setup Script for MySQL
-- Run this script to create the database and user

-- Create database
CREATE DATABASE IF NOT EXISTS swapit 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Create user (adjust password as needed)
CREATE USER IF NOT EXISTS 'swapit'@'localhost' IDENTIFIED BY 'swapit123';

-- Grant all privileges on swapit database to swapit user
GRANT ALL PRIVILEGES ON swapit.* TO 'swapit'@'localhost';

-- Grant privileges for remote connections (optional)
CREATE USER IF NOT EXISTS 'swapit'@'%' IDENTIFIED BY 'swapit123';
GRANT ALL PRIVILEGES ON swapit.* TO 'swapit'@'%';

-- Flush privileges to ensure changes take effect
FLUSH PRIVILEGES;

-- Use the database
USE swapit;

-- Create tables (these will be auto-created by Hibernate, but here for reference)

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    bio VARCHAR(500),
    profile_image_url VARCHAR(500),
    points INT DEFAULT 0,
    trust_score INT DEFAULT 100,
    is_verified BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    role ENUM('USER', 'ADMIN', 'MODERATOR') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Items table
CREATE TABLE IF NOT EXISTS items (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description VARCHAR(1000),
    points_value INT NOT NULL,
    image_url VARCHAR(500),
    category ENUM('ELECTRONICS', 'FURNITURE', 'CLOTHING', 'BOOKS', 'SPORTS', 'HOME_GARDEN', 'AUTOMOTIVE', 'COLLECTIBLES', 'OTHER') DEFAULT 'OTHER',
    condition ENUM('NEW', 'LIKE_NEW', 'GOOD', 'FAIR', 'POOR') DEFAULT 'GOOD',
    status ENUM('AVAILABLE', 'PENDING', 'SOLD', 'REMOVED') DEFAULT 'AVAILABLE',
    owner_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Transactions table
CREATE TABLE IF NOT EXISTS transactions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    item_id BIGINT NOT NULL,
    buyer_id BIGINT NOT NULL,
    seller_id BIGINT NOT NULL,
    points_amount INT NOT NULL,
    status ENUM('PENDING', 'CONFIRMED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED', 'DISPUTED') DEFAULT 'PENDING',
    notes VARCHAR(500),
    meeting_location VARCHAR(100),
    meeting_time TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE,
    FOREIGN KEY (buyer_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_points ON users(points DESC);
CREATE INDEX IF NOT EXISTS idx_users_trust_score ON users(trust_score DESC);
CREATE INDEX IF NOT EXISTS idx_items_owner ON items(owner_id);
CREATE INDEX IF NOT EXISTS idx_items_status ON items(status);
CREATE INDEX IF NOT EXISTS idx_items_category ON items(category);
CREATE INDEX IF NOT EXISTS idx_transactions_buyer ON transactions(buyer_id);
CREATE INDEX IF NOT EXISTS idx_transactions_seller ON transactions(seller_id);
CREATE INDEX IF NOT EXISTS idx_transactions_status ON transactions(status);

-- Insert sample data (optional)
INSERT IGNORE INTO users (username, email, password, first_name, last_name, points, trust_score, is_verified, role) VALUES
('admin', 'admin@swapit.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Admin', 'User', 10000, 100, TRUE, 'ADMIN'),
('alexchen', 'alex@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Alex', 'Chen', 5000, 95, TRUE, 'USER'),
('sarahjohnson', 'sarah@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Sarah', 'Johnson', 4200, 90, TRUE, 'USER'),
('mikewilson', 'mike@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Mike', 'Wilson', 3800, 85, FALSE, 'USER');

-- Insert sample items
INSERT IGNORE INTO items (title, description, points_value, image_url, category, condition, status, owner_id) VALUES
('MacBook Pro 2023', 'Latest MacBook Pro in excellent condition', 2500, 'https://via.placeholder.com/300x200.png?text=MacBook+Pro', 'ELECTRONICS', 'LIKE_NEW', 'AVAILABLE', 2),
('Gaming Chair', 'Ergonomic gaming chair with RGB lighting', 800, 'https://via.placeholder.com/300x200.png?text=Gaming+Chair', 'FURNITURE', 'GOOD', 'AVAILABLE', 3),
('iPhone 15', 'Brand new iPhone 15, unopened', 1800, 'https://via.placeholder.com/300x200.png?text=iPhone+15', 'ELECTRONICS', 'NEW', 'AVAILABLE', 2),
('Office Desk', 'Modern office desk with drawers', 600, 'https://via.placeholder.com/300x200.png?text=Office+Desk', 'FURNITURE', 'GOOD', 'AVAILABLE', 4);

-- Show success message
SELECT 'SWAPIT database setup completed successfully!' as message;
