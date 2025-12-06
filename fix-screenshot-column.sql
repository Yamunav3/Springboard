-- Fix screenshot_url column to support Base64 data URIs
-- Run this in MySQL before restarting the application

USE automation_framework;

-- Modify the screenshot_url column to LONGTEXT to support large Base64 strings
ALTER TABLE reports MODIFY COLUMN screenshot_url LONGTEXT;

-- Verify the change
DESCRIBE reports;

SELECT 'Screenshot URL column updated successfully!' AS Status;
