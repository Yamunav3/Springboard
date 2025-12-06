# MySQL Database Setup Script for Automated Testing Framework

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "MySQL Database Setup" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Prompt for MySQL root password
$mysqlPassword = Read-Host "Enter your MySQL root password" -AsSecureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($mysqlPassword)
$password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

Write-Host ""
Write-Host "Creating database 'automation_framework'..." -ForegroundColor Yellow

# Create the database
$mysqlPath = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
& $mysqlPath -u root "-p$password" -e "CREATE DATABASE IF NOT EXISTS automation_framework;"

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Database created successfully!" -ForegroundColor Green
    
    # Show databases
    Write-Host ""
    Write-Host "Available databases:" -ForegroundColor Yellow
    & $mysqlPath -u root "-p$password" -e "SHOW DATABASES;"
    
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "Database setup completed!" -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Update application.properties with your MySQL password"
    Write-Host "2. Run: mvn clean install -DskipTests"
    Write-Host "3. Run: java -jar target\automated-testing-framework-1.0.0.jar"
    Write-Host ""
} else {
    Write-Host "✗ Failed to create database. Please check your MySQL password." -ForegroundColor Red
}
