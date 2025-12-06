# Quick Setup Script for Email Notifications & CI/CD

Write-Host "`n================================================" -ForegroundColor Cyan
Write-Host "Email Notifications & CI/CD Setup" -ForegroundColor Green
Write-Host "================================================`n" -ForegroundColor Cyan

# Step 1: Brevo API Key
Write-Host "Step 1: Brevo Email Notifications" -ForegroundColor Yellow
Write-Host "-----------------------------------" -ForegroundColor Gray
Write-Host "1. Go to: https://www.brevo.com"
Write-Host "2. Sign up for free account"
Write-Host "3. Get API key from: Settings → SMTP & API → API Keys"
Write-Host ""
$brevoKey = Read-Host "Enter your Brevo API key (or press Enter to skip)"

if ($brevoKey) {
    Write-Host "`nUpdating application.properties..." -ForegroundColor Yellow
    $propsFile = "src\main\resources\application.properties"
    $content = Get-Content $propsFile -Raw
    $content = $content -replace 'brevo\.api-key=\$\{brevo_api_key:\}', "brevo.api-key=$brevoKey"
    Set-Content $propsFile $content
    Write-Host "✓ Brevo API key configured!" -ForegroundColor Green
} else {
    Write-Host "⚠ Skipping Brevo setup. Email notifications will not work." -ForegroundColor Yellow
}

Write-Host "`n================================================" -ForegroundColor Cyan
Write-Host "Step 2: GitHub Actions CI/CD" -ForegroundColor Yellow
Write-Host "-----------------------------------" -ForegroundColor Gray
Write-Host "After rebuilding the app, go to:" -ForegroundColor White
Write-Host "http://localhost:5000/dashboard" -ForegroundColor Cyan
Write-Host ""
Write-Host "Then:" -ForegroundColor White
Write-Host "1. Select your project"
Write-Host "2. Click 'Download GitHub Action' button"
Write-Host "3. Save to: .github/workflows/ in your repo"
Write-Host "4. Add GitHub secrets (see guide)"
Write-Host "5. Push to trigger the workflow"
Write-Host ""

# Step 3: Rebuild
Write-Host "`n================================================" -ForegroundColor Cyan
Write-Host "Step 3: Rebuild Application" -ForegroundColor Yellow
Write-Host "-----------------------------------" -ForegroundColor Gray
$rebuild = Read-Host "Rebuild application now? (y/n)"

if ($rebuild -eq 'y' -or $rebuild -eq 'Y') {
    Write-Host "`nRebuilding..." -ForegroundColor Yellow
    $env:JAVA_HOME = 'C:\Program Files\Java\jdk-23'
    mvn clean package -DskipTests
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n✓ Build successful!" -ForegroundColor Green
        Write-Host ""
        $run = Read-Host "Start application now? (y/n)"
        
        if ($run -eq 'y' -or $run -eq 'Y') {
            Write-Host "`nStarting application..." -ForegroundColor Green
            Write-Host "================================================`n" -ForegroundColor Cyan
            java -jar target\automated-testing-framework-1.0.0.jar
        }
    } else {
        Write-Host "`n✗ Build failed!" -ForegroundColor Red
    }
} else {
    Write-Host "`nTo rebuild manually, run:" -ForegroundColor Yellow
    Write-Host "`$env:JAVA_HOME = 'C:\Program Files\Java\jdk-23'" -ForegroundColor White
    Write-Host "mvn clean package -DskipTests" -ForegroundColor White
    Write-Host "java -jar target\automated-testing-framework-1.0.0.jar" -ForegroundColor White
}

Write-Host "`n================================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "📖 Full guide: NOTIFICATIONS_AND_CICD_SETUP.md" -ForegroundColor Cyan
Write-Host "🌐 Dashboard: http://localhost:5000/dashboard" -ForegroundColor Cyan
Write-Host "📧 Email: yamunav32006@gmail.com" -ForegroundColor Cyan
Write-Host ""
