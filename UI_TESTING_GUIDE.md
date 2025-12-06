# 🎯 UI Testing Guide - Automated Testing Framework

## 📋 Table of Contents

1. [What is UI Testing?](#what-is-ui-testing)
2. [How to Access UI Testing](#how-to-access)
3. [Creating Your First UI Test](#creating-ui-test)
4. [UI Test Actions Reference](#actions-reference)
5. [Step-by-Step Examples](#examples)
6. [Running Tests](#running-tests)
7. [Understanding Test Results](#test-results)

---

## 🔍 What is UI Testing?

UI Testing (User Interface Testing) in this framework uses **Selenium WebDriver** to automate browser interactions. It simulates a real user:

- Opening web pages
- Clicking buttons
- Filling forms
- Validating content
- Taking screenshots

**Benefits:**

- ✅ Automated regression testing
- ✅ Cross-browser compatibility checks
- ✅ Visual proof with screenshots
- ✅ Faster than manual testing

---

## 🚀 How to Access UI Testing

### Step 1: Start the Application

```powershell
cd c:\Users\yamun\Projects\Springboard
$env:JAVA_HOME = 'C:\Program Files\Java\jdk-23'
java -jar target\automated-testing-framework-1.0.0.jar
```

### Step 2: Open Browser

Navigate to: **http://localhost:5000**

### Step 3: Sign In with Clerk

Use your Clerk account to authenticate

### Step 4: Navigate to Test Management

Click on **"Test Management"** in the navigation menu

---

## 📝 Creating Your First UI Test

### Method 1: Using the Web Interface

1. **Select or Create a Project**

   - Go to Test Management page
   - Choose an existing project or create a new one

2. **Click "Create New Test"**

3. **Fill in Test Details:**

   - **Name:** Give your test a descriptive name (e.g., "Login Page Test")
   - **Type:** Select **"UI"** from dropdown
   - **Definition JSON:** Enter your test steps (see examples below)

4. **Click "Save Test"**

---

## 🎬 UI Test Actions Reference

### Available Actions

#### 1. **navigate** - Open a URL

```json
{
  "action": "navigate",
  "url": "https://example.com"
}
```

#### 2. **click** - Click an element

```json
{
  "action": "click",
  "selector": "#login-button",
  "by": "css"
}
```

#### 3. **type** - Enter text into input field

```json
{
  "action": "type",
  "selector": "#username",
  "by": "css",
  "text": "testuser@example.com"
}
```

#### 4. **assert** - Verify text exists on page

```json
{
  "action": "assert",
  "selector": "h1",
  "by": "css",
  "expected": "Welcome"
}
```

#### 5. **wait** - Pause execution

```json
{
  "action": "wait",
  "seconds": 2
}
```

#### 6. **select** - Choose dropdown option

```json
{
  "action": "select",
  "selector": "#country",
  "by": "css",
  "option": "United States"
}
```

### Selector Types ("by" field)

- **`css`** - CSS Selector (recommended)
  - Examples: `#id`, `.class`, `button[type="submit"]`
- **`id`** - Element ID
  - Example: `username`
- **`name`** - Element name attribute
  - Example: `email`
- **`xpath`** - XPath expression
  - Example: `//button[contains(text(),'Login')]`
- **`tag`** - HTML tag name
  - Example: `button`

---

## 💡 Step-by-Step Examples

### Example 1: Simple Google Search Test

```json
{
  "steps": [
    {
      "action": "navigate",
      "url": "https://www.google.com"
    },
    {
      "action": "type",
      "selector": "textarea[name='q']",
      "by": "css",
      "text": "Selenium WebDriver"
    },
    {
      "action": "click",
      "selector": "input[name='btnK']",
      "by": "css"
    },
    {
      "action": "wait",
      "seconds": 2
    },
    {
      "action": "assert",
      "selector": "#search",
      "by": "css",
      "expected": "Selenium"
    }
  ]
}
```

**What this test does:**

1. Opens Google
2. Types "Selenium WebDriver" in search box
3. Clicks search button
4. Waits 2 seconds
5. Verifies "Selenium" appears in results

---

### Example 2: Login Form Test

```json
{
  "steps": [
    {
      "action": "navigate",
      "url": "https://example.com/login"
    },
    {
      "action": "type",
      "selector": "#email",
      "by": "css",
      "text": "user@example.com"
    },
    {
      "action": "type",
      "selector": "#password",
      "by": "css",
      "text": "password123"
    },
    {
      "action": "click",
      "selector": "button[type='submit']",
      "by": "css"
    },
    {
      "action": "wait",
      "seconds": 3
    },
    {
      "action": "assert",
      "selector": ".welcome-message",
      "by": "css",
      "expected": "Welcome"
    }
  ]
}
```

**What this test does:**

1. Opens login page
2. Enters email
3. Enters password
4. Clicks submit button
5. Waits for redirect
6. Verifies welcome message appears

---

### Example 3: E-commerce Product Search

```json
{
  "steps": [
    {
      "action": "navigate",
      "url": "https://www.amazon.com"
    },
    {
      "action": "type",
      "selector": "#twotabsearchtextbox",
      "by": "css",
      "text": "laptop"
    },
    {
      "action": "click",
      "selector": "#nav-search-submit-button",
      "by": "css"
    },
    {
      "action": "wait",
      "seconds": 3
    },
    {
      "action": "assert",
      "selector": "span.a-color-state",
      "by": "css",
      "expected": "laptop"
    }
  ]
}
```

---

### Example 4: Form with Dropdown

```json
{
  "steps": [
    {
      "action": "navigate",
      "url": "https://example.com/register"
    },
    {
      "action": "type",
      "selector": "#fullName",
      "by": "css",
      "text": "John Doe"
    },
    {
      "action": "type",
      "selector": "#email",
      "by": "css",
      "text": "john@example.com"
    },
    {
      "action": "select",
      "selector": "#country",
      "by": "css",
      "option": "United States"
    },
    {
      "action": "click",
      "selector": "input[type='checkbox']",
      "by": "css"
    },
    {
      "action": "click",
      "selector": "button[type='submit']",
      "by": "css"
    },
    {
      "action": "wait",
      "seconds": 2
    },
    {
      "action": "assert",
      "selector": ".success-message",
      "by": "css",
      "expected": "Registration successful"
    }
  ]
}
```

---

## ▶️ Running Tests

### Option 1: Run Single Test

1. Go to **Test Management** page
2. Find your test in the list
3. Click the **"Run"** button (▶️ icon)
4. Wait for execution to complete
5. View results automatically

### Option 2: Run Test Suite (All Tests in Project)

1. Go to **Test Management** page
2. Click **"Run All Tests"** button
3. All tests in the current project will execute
4. View combined results

### Option 3: Schedule Tests

1. Go to **Scheduler** page
2. Create a new schedule
3. Select project and frequency (Daily, Weekly, etc.)
4. Tests will run automatically

---

## 📊 Understanding Test Results

### Test Status Types

- ✅ **PASSED** - All steps executed successfully
- ❌ **FAILED** - One or more steps failed
- ⚠️ **ERROR** - Technical error occurred (e.g., element not found)

### Viewing Test Reports

1. Go to **Reports** page
2. Filter by:
   - Project
   - Test type (UI/API)
   - Status
   - Date range
3. Click on a report to see:
   - Execution time
   - Step-by-step details
   - Error messages (if failed)
   - Screenshot (if available)

### Screenshot Capture

Screenshots are automatically taken when:

- ❌ A test fails
- ✅ Test completes successfully (final state)

Screenshots help you visually debug issues.

---

## 🔧 Tips and Best Practices

### 1. **Use Descriptive Test Names**

❌ Bad: "Test 1"
✅ Good: "Login - Valid Credentials - Success"

### 2. **Add Wait Times**

After clicks or page loads, add `wait` actions to ensure elements are loaded:

```json
{
  "action": "wait",
  "seconds": 2
}
```

### 3. **Prefer CSS Selectors**

CSS selectors are faster and more reliable than XPath:

```json
"selector": "#submit-button",
"by": "css"
```

### 4. **Use Specific Selectors**

❌ Weak: `"selector": "button"`
✅ Strong: `"selector": "button[type='submit']"`

### 5. **Test One Thing at a Time**

Break complex workflows into smaller, focused tests.

### 6. **Add Assertions**

Always verify expected outcomes:

```json
{
  "action": "assert",
  "selector": ".success",
  "by": "css",
  "expected": "Success"
}
```

---

## 🐛 Troubleshooting

### Problem: Element Not Found

**Solution:**

- Check selector is correct
- Add `wait` before the action
- Use browser DevTools to inspect element

### Problem: Test Times Out

**Solution:**

- Increase wait times
- Check if page is loading slowly
- Verify URL is accessible

### Problem: Click Not Working

**Solution:**

- Element might be hidden or covered
- Try scrolling to element first
- Check if element is inside an iframe

---

## 🎓 Quick Start Checklist

- [ ] Application is running (http://localhost:5000)
- [ ] Signed in with Clerk account
- [ ] Project created
- [ ] First UI test created
- [ ] Test executed successfully
- [ ] Report viewed

---

## 📞 Need Help?

1. Check the **Reports** page for detailed error messages
2. Review this guide's examples
3. Ensure Chrome browser is installed (required for Selenium)
4. Check application logs in terminal

---

## 🚀 Next Steps

Once you're comfortable with UI testing:

1. Create test suites for different workflows
2. Schedule automated regression tests
3. Integrate with CI/CD pipelines
4. Export reports for stakeholders

Happy Testing! 🎉
