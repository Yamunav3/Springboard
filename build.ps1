# Set JAVA_HOME for this session
$env:JAVA_HOME = 'C:\Program Files\Java\jdk-23'

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Building Automated Testing Framework..." -ForegroundColor Green
Write-Host "JAVA_HOME: $env:JAVA_HOME" -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Clean and build the project
mvn clean install -DskipTests
