# 🔔 Email Notifications & CI/CD Setup Guide

## Part 1: Email Notifications Setup

### Step 1: Get Brevo API Key (Free)

1. **Sign up for Brevo**

   - Go to: https://www.brevo.com
   - Click "Sign up free"
   - Complete registration

2. **Get API Key**
   - Log in to Brevo dashboard
   - Go to: **Settings** → **SMTP & API** → **API Keys**
   - Click **"Generate a new API key"**
   - Name it: "Test Automation Notifications"
   - Copy the key (you'll only see it once!)

### Step 2: Configure Application

1. **Update application.properties**

   - Open: `c:\Users\yamun\Projects\Springboard\src\main\resources\application.properties`
   - Find the Brevo section and update:

   ```properties
   brevo.api-key=your_api_key_here
   brevo.sender.email=yamunav32006@gmail.com
   brevo.sender.name=Test Automation Platform
   ```

2. **Rebuild the application**

   ```powershell
   cd c:\Users\yamun\Projects\Springboard
   $env:JAVA_HOME = 'C:\Program Files\Java\jdk-23'
   mvn clean package -DskipTests
   ```

3. **Restart the application**
   ```powershell
   java -jar target\automated-testing-framework-1.0.0.jar
   ```

### Step 3: Test Email Notifications

1. **Add Recipients to Project**

   - Go to: http://localhost:5000/dashboard
   - Select your project
   - Scroll to "Integration Settings"
   - Add email addresses for notifications

2. **Run a Test**
   - Go to Test Management
   - Run any test
   - Check your email inbox!

### What You'll Receive in Email:

```
Subject: [Project Name] - Automated test results

Body:
┌─────────────────────────────────────────┐
│ Automation run summary for [Project]    │
├─────────────────────────────────────────┤
│ Passed: 2 | Failed: 1                   │
├─────────────────────────────────────────┤
│ Test          │ Status  │ Type │ Error  │
├───────────────┼─────────┼──────┼────────┤
│ Login Test    │ PASSED  │ UI   │        │
│ Search Test   │ PASSED  │ UI   │        │
│ Checkout Test │ FAILED  │ UI   │ Element│
│               │         │      │ not    │
│               │         │      │ found  │
└───────────────┴─────────┴──────┴────────┘
```

---

## Part 2: GitHub Actions CI/CD Workflow

### Step 1: Download GitHub Actions Workflow

**Option A: From Dashboard (Easiest)**

1. Go to: http://localhost:5000/dashboard
2. Select your project
3. Look for **"Download GitHub Action"** button
4. Click to download `automation-workflow-[id].yml`

**Option B: Direct URL**

Navigate to:

```
http://localhost:5000/dashboard/project/{projectId}/github-action
```

Replace `{projectId}` with your project ID (visible in URL)

### Step 2: Add to Your GitHub Repository

1. **Create workflow directory** (if not exists)

   ```powershell
   cd path\to\your\github\repo
   mkdir -p .github\workflows
   ```

2. **Copy the downloaded file**

   ```powershell
   copy C:\Users\yamun\Downloads\automation-workflow-*.yml .github\workflows\test-automation.yml
   ```

3. **Commit and push**
   ```powershell
   git add .github/workflows/test-automation.yml
   git commit -m "Add automated testing workflow"
   git push
   ```

### Step 3: Configure GitHub Secrets

1. **Go to your GitHub repository**

   - Navigate to: **Settings** → **Secrets and variables** → **Actions**

2. **Add these secrets**:

   | Secret Name       | Value                     | Description                     |
   | ----------------- | ------------------------- | ------------------------------- |
   | `TEST_SERVER_URL` | `https://your-server.com` | Your test automation server URL |
   | `TEST_API_TOKEN`  | `your_token_here`         | Authentication token            |
   | `MYSQL_PASSWORD`  | `@Yamunav3@`              | MySQL password for test DB      |

### Step 4: Customize Workflow Triggers

Edit `.github/workflows/test-automation.yml`:

```yaml
name: Automated Testing

# When to run tests
on:
  push:
    branches: [main, develop] # Run on push to these branches
  pull_request:
    branches: [main] # Run on PRs to main
  schedule:
    - cron: "0 2 * * *" # Run daily at 2 AM UTC
  workflow_dispatch: # Manual trigger

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Run UI Tests
        run: |
          curl -X POST "${{ secrets.TEST_SERVER_URL }}/api/projects/$PROJECT_ID/run-suite" \
            -H "Authorization: Bearer ${{ secrets.TEST_API_TOKEN }}"

      - name: Check test results
        if: failure()
        run: |
          echo "Tests failed! Check reports."
          exit 1
```

### Step 5: Configure Notifications in GitHub

**Option A: Email Notifications**

- GitHub automatically sends emails for failed workflows
- Configure in: **Settings** → **Notifications** → **Actions**

**Option B: Slack Integration**

Add to your workflow:

```yaml
- name: Notify Slack on Failure
  if: failure()
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    text: "UI Tests Failed! Check the logs."
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
```

**Option C: Discord Integration**

Add to your workflow:

```yaml
- name: Notify Discord on Failure
  if: failure()
  uses: sarisia/actions-status-discord@v1
  with:
    webhook: ${{ secrets.DISCORD_WEBHOOK }}
    status: ${{ job.status }}
    title: "Test Automation Failed"
    description: "UI tests failed on ${{ github.ref }}"
```

---

## Part 3: Complete Notification Flow

### When Tests Fail:

1. **Immediate Email** (Brevo)

   - Sent to project recipients
   - Detailed test report
   - Error messages included

2. **GitHub Actions Notification**

   - Red ❌ badge on commit
   - Email from GitHub (if enabled)
   - PR checks fail (if on PR)
   - Optional: Slack/Discord webhook

3. **Dashboard Updates**
   - Test status updated
   - Report generated
   - Screenshot captured (if UI test)

---

## Part 4: Testing Your Setup

### Test Email Notifications:

1. **Run a test that will fail**:

   ```json
   {
     "steps": [
       {
         "action": "navigate",
         "url": "https://google.com"
       },
       {
         "action": "assert",
         "selector": "#fake-element",
         "by": "css",
         "expected": "This will fail"
       }
     ]
   }
   ```

2. **Check your email** (should arrive within seconds)

### Test GitHub Actions:

1. **Push any commit to trigger workflow**:

   ```powershell
   git commit --allow-empty -m "Test CI/CD workflow"
   git push
   ```

2. **Check GitHub Actions tab** in your repository

3. **View workflow run** and logs

---

## Part 5: Advanced Configuration

### Conditional Notifications (Only on Failure)

Modify `NotificationService.java` to only send on failures:

```java
public void notifyRunCompletion(Project project, List<Report> reports, List<User> recipients) {
    // Only notify if there are failures
    long failed = reports.stream()
        .filter(r -> !"PASSED".equalsIgnoreCase(r.getStatus()))
        .count();

    if (failed == 0) {
        log.info("All tests passed, skipping notification");
        return;
    }

    // Send notification...
}
```

### Multiple Email Templates

Create different templates for:

- ✅ All tests passed
- ❌ Some tests failed
- ⚠️ Critical tests failed
- 📊 Daily summary

---

## Troubleshooting

### Email Not Sending?

1. **Check Brevo API key is correct**

   ```powershell
   # Test Brevo API
   curl -X GET "https://api.brevo.com/v3/account" -H "api-key: YOUR_KEY"
   ```

2. **Check application logs**

   - Look for: "Brevo API key missing" warning
   - Or: "Failed to notify via Brevo" error

3. **Verify sender email**
   - Must be verified in Brevo dashboard
   - Go to: **Senders** → **Add a sender**

### GitHub Actions Not Triggering?

1. **Check workflow file syntax**

   ```powershell
   # Validate YAML
   yamllint .github/workflows/test-automation.yml
   ```

2. **Check repository settings**

   - **Settings** → **Actions** → **General**
   - Ensure "Allow all actions" is selected

3. **Check branch protection rules**
   - Ensure workflows can run on protected branches

---

## Quick Reference Commands

### Rebuild with Email Notifications:

```powershell
cd c:\Users\yamun\Projects\Springboard
$env:JAVA_HOME = 'C:\Program Files\Java\jdk-23'
mvn clean package -DskipTests
java -jar target\automated-testing-framework-1.0.0.jar
```

### Download GitHub Workflow:

```
http://localhost:5000/dashboard/project/1/github-action
```

### Test Email API:

```powershell
curl -X POST http://localhost:5000/api/test-notification \
  -H "Content-Type: application/json"
```

---

## Summary Checklist

- [ ] Brevo account created
- [ ] API key obtained
- [ ] application.properties updated
- [ ] Application rebuilt and restarted
- [ ] Test email received
- [ ] GitHub Actions workflow downloaded
- [ ] Workflow added to repository
- [ ] GitHub secrets configured
- [ ] Test commit pushed
- [ ] Workflow executed successfully
- [ ] GitHub notification received

---

## Next Steps

1. **Customize email templates** for better branding
2. **Add Slack/Discord webhooks** for team notifications
3. **Set up scheduled test runs** in the Scheduler page
4. **Configure branch-specific tests** in GitHub Actions
5. **Add status badges** to README.md

Need help with any specific step? Let me know! 🚀
