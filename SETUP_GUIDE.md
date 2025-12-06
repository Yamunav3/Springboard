# MySQL Setup and Configuration Guide

## Prerequisites

✓ Java 23 - Installed
✓ Maven 3.9.11 - Installed
✓ MySQL 8.0.42 - Installed and Running

## Step-by-Step Setup

### 1. Create the Database

You have two options:

#### Option A: Using the PowerShell Script (Recommended)

```powershell
powershell -ExecutionPolicy Bypass -File setup-mysql.ps1
```

#### Option B: Manual MySQL Command

```powershell
mysql -u root -p
```

Then run:

```sql
CREATE DATABASE IF NOT EXISTS automation_framework;
SHOW DATABASES;
EXIT;
```

### 2. Configure Database Password

The application is configured to use these MySQL settings:

- **Host:** localhost
- **Port:** 3306
- **Database:** automation_framework
- **Username:** root
- **Password:** Set via environment variable `MYSQL_PASSWORD`

If you have a MySQL root password, set it as an environment variable:

```powershell
$env:MYSQL_PASSWORD = "your_password_here"
```

If you don't have a password (empty), you can leave it unset.

### 3. Rebuild the Application

After updating the configuration:

```powershell
$env:JAVA_HOME = 'C:\Program Files\Java\jdk-23'
mvn clean install -DskipTests
```

### 4. Run the Application

#### Option A: Using the Startup Script (Recommended)

```powershell
powershell -ExecutionPolicy Bypass -File start-app.ps1
```

#### Option B: Manual Command

```powershell
$env:JAVA_HOME = 'C:\Program Files\Java\jdk-23'
$env:MYSQL_PASSWORD = "your_password"
java -jar target\automated-testing-framework-1.0.0.jar
```

### 5. Access the Application

Once started, the application will be available at:

- **URL:** http://localhost:5000
- Check the console output for the exact port

## Environment Variables Reference

### Required

- `JAVA_HOME` - Path to JDK 23 (already set)
- `MYSQL_PASSWORD` - Your MySQL root password

### Optional (for full functionality)

- `brevo_api_key` - Email service API key
- `imagekit_public_key` - Image hosting public key
- `imagekit_private_key` - Image hosting private key
- `imagekit_upload_url` - Image upload endpoint
- `clerk_publishable_key` - Authentication service key
- `clerk_secret_key` - Authentication service secret

## Troubleshooting

### MySQL Connection Failed

- Verify MySQL service is running: `Get-Service MySQL80`
- Test connection: `mysql -u root -p`
- Check password is correct

### Build Failures

- Ensure JAVA_HOME is set: `echo $env:JAVA_HOME`
- Verify Maven: `mvn --version`
- Clean Maven cache: `mvn clean`

### Port Already in Use

- Check what's using port 5000: `netstat -ano | findstr :5000`
- Change port in `application.properties`: `server.port=8080`

## Quick Start Commands

```powershell
# 1. Setup database
powershell -ExecutionPolicy Bypass -File setup-mysql.ps1

# 2. Set environment
$env:JAVA_HOME = 'C:\Program Files\Java\jdk-23'
$env:MYSQL_PASSWORD = "your_password"

# 3. Build project
mvn clean install -DskipTests

# 4. Run application
java -jar target\automated-testing-framework-1.0.0.jar
```

## Notes

- The application uses Hibernate DDL auto-update, so tables will be created automatically
- First startup may take longer as Hibernate creates the schema
- Check logs in the console for any startup issues
