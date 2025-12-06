# Complete Environment Setup and Run Script

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Automated Testing Framework - Startup Script" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Set JAVA_HOME
$env:JAVA_HOME = 'C:\Program Files\Java\jdk-23'
Write-Host "✓ JAVA_HOME set to: $env:JAVA_HOME" -ForegroundColor Green

# Prompt for MySQL password if not set
if (-not $env:MYSQL_PASSWORD) {
    Write-Host ""
    $mysqlPassword = Read-Host "Enter your MySQL root password (press Enter if none)" -AsSecureString
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($mysqlPassword)
    $env:MYSQL_PASSWORD = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
}

# Prompt for other required environment variables
Write-Host ""
Write-Host "Setting up environment variables..." -ForegroundColor Yellow
Write-Host "Note: Press Enter to skip optional variables" -ForegroundColor Gray
Write-Host ""

if (-not $env:brevo_api_key) {
    $env:brevo_api_key = Read-Host "Enter Brevo API Key (optional)"
}

if (-not $env:imagekit_public_key) {
    $env:imagekit_public_key = Read-Host "Enter ImageKit Public Key (optional)"
}

if (-not $env:imagekit_private_key) {
    $env:imagekit_private_key = Read-Host "Enter ImageKit Private Key (optional)"
}

if (-not $env:imagekit_upload_url) {
    $env:imagekit_upload_url = Read-Host "Enter ImageKit Upload URL (optional)"
}

if (-not $env:clerk_publishable_key) {
    $env:clerk_publishable_key = Read-Host "Enter Clerk Publishable Key (optional)"
}

if (-not $env:clerk_secret_key) {
    $env:clerk_secret_key = Read-Host "Enter Clerk Secret Key (optional)"
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Starting Application..." -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Run the application
java -jar target\automated-testing-framework-1.0.0.jar
