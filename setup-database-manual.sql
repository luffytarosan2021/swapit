-- Manual MySQL Setup for SWAPIT
-- Run this with: mysql -u root < setup-database-manual.sql

-- Create database
CREATE DATABASE IF NOT EXISTS swapit 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Create user
CREATE USER IF NOT EXISTS 'swapit'@'localhost' IDENTIFIED BY 'swapit123';

-- Grant privileges
GRANT ALL PRIVILEGES ON swapit.* TO 'swapit'@'localhost';

-- Flush privileges
FLUSH PRIVILEGES;

-- Use the database
USE swapit;

-- Create tables
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

-- Insert sample data
INSERT IGNORE INTO users (username, email, password, first_name, last_name, points, trust_score, is_verified, role) VALUES
('admin', 'admin@swapit.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Admin', 'User', 10000, 100, TRUE, 'ADMIN'),
('alexchen', 'alex@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Alex', 'Chen', 5000, 95, TRUE, 'USER'),
('sarahjohnson', 'sarah@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Sarah', 'Johnson', 4200, 90, TRUE, 'USER'),
('mikewilson', 'mike@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'Mike', 'Wilson', 3800, 85, FALSE, 'USER');

INSERT IGNORE INTO items (title, description, points_value, image_url, category, condition, status, owner_id) VALUES
('MacBook Pro 2023', 'Latest MacBook Pro in excellent condition', 2500, 'https://via.placeholder.com/300x200.png?text=MacBook+Pro', 'ELECTRONICS', 'LIKE_NEW', 'AVAILABLE', 2),
('Gaming Chair', 'Ergonomic gaming chair with RGB lighting', 800, 'https://via.placeholder.com/300x200.png?text=Gaming+Chair', 'FURNITURE', 'GOOD', 'AVAILABLE', 3),
('iPhone 15', 'Brand new iPhone 15, unopened', 1800, 'https://via.placeholder.com/300x200.png?text=iPhone+15', 'ELECTRONICS', 'NEW', 'AVAILABLE', 2),
('Office Desk', 'Modern office desk with drawers', 600, 'https://via.placeholder.com/300x200.png?text=Office+Desk', 'FURNITURE', 'GOOD', 'AVAILABLE', 4);

SELECT 'SWAPIT database setup completed successfully!' as message;
