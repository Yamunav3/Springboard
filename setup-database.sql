-- Create database for Automated Testing Framework
CREATE DATABASE IF NOT EXISTS automation_framework;

-- Use the database
USE automation_framework;

-- Create a user for the application (optional - you can use root)
-- CREATE USER IF NOT EXISTS 'automation_user'@'localhost' IDENTIFIED BY 'automation_pass';
-- GRANT ALL PRIVILEGES ON automation_framework.* TO 'automation_user'@'localhost';
-- FLUSH PRIVILEGES;

-- Show databases to confirm
SHOW DATABASES;

SELECT 'Database setup completed successfully!' AS Status;
