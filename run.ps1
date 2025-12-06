# Set JAVA_HOME for this session
$env:JAVA_HOME = 'C:\Program Files\Java\jdk-23'

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Starting Automated Testing Framework..." -ForegroundColor Green
Write-Host "JAVA_HOME: $env:JAVA_HOME" -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Run the Spring Boot application
mvn spring-boot:run
