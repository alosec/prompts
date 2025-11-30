---
name: Feature Branch Testing with Visual Email Reports
description: Guide feature branch deployment and E2E testing workflow with screenshot email reports. Activate when user mentions testing, deploying feature branch, e2e tests, test deployment, validate feature, visual testing, test against live URL, or wants automated visual feedback on feature development.
allowed-tools: Bash, Read, Write, Edit, Glob, Grep
---

# Feature Branch Testing with Visual Email Reports

## When to Use

Activate whenever the user asks to:
- Test a feature branch deployment
- Deploy and validate a feature with E2E tests
- Get visual feedback on how a feature looks across devices
- Run tests against a live deployment URL
- Validate feature implementation with screenshots
- Debug feature issues with multi-breakpoint visual evidence
- Set up E2E tests for a new feature

## Core Philosophy

**Every feature needs E2E tests with visual validation across the user journey.**

The standard workflow is:
1. Build feature on branch
2. Deploy to Cloudflare Pages (get unique URL)
3. Run E2E tests against deployment
4. Receive email with screenshots showing user journey at mobile/tablet/desktop
5. Iterate based on visual feedback
6. Merge when tests pass and UI looks good

## Development Process

The complete feature development cycle:

1. **Prepare** - Orient to codebase, read memory bank, understand requirements
2. **Analyze** - Research existing patterns, identify integration points
3. **Plan** - Design implementation, create file structure plan
4. **Code** - Implement feature following plan
5. **Test & Review** - Deploy feature branch, run E2E tests with visual reports
6. **Merge** - Merge to main when tests pass and UI looks good
7. **Prepare Next** - Update memory bank, document patterns, identify next work

This skill focuses on **Step 5: Test & Review** using the feature branch deployment pattern.

## Feature Branch Deployment Pattern

### Step 1: Create Feature Branch
```bash
git checkout -b feature/descriptive-name
```

### Step 2: Build and Deploy
```bash
# Build the feature
npm run build 2>&1 | tail -20

# Deploy to Cloudflare Pages (creates unique URL)
wrangler pages deploy dist/ 2>&1 | grep -E "(https://|Success|Deployment)"
```

**Capture deployment URL:**
- Hash URL: `https://[hash].your-project.pages.dev`
- Branch alias: `https://feature-[branch-name].your-project.pages.dev`

### Step 3: Run E2E Tests Against Deployment

**Standard pattern (always use deployed URL):**
```bash
SEND_TEST_EMAILS=true PLAYWRIGHT_BASE_URL=https://feature-branch.your-project.pages.dev npm run test -- test-name
```

**Why not localhost?**
- AI features require Cloudflare runtime environment
- No local Anthropic API key (security)
- Real-world conditions: auth, env vars, edge functions
- Testing actual deployment validates production behavior

### Step 4: Receive Visual Email Report

Email arrives showing the complete user journey:
- **Summary:** Test stats (X/Y passed, pass rate, duration, timestamp)
- **User Journey:** Each step of the flow with status icon (✅/❌)
- **Visual Evidence:** Screenshots at mobile/tablet/desktop for every step
- **Errors:** Clear error messages if tests fail

**Example for booking flow:**
```
Test Results - 5/5 Passed (100%)

✅ User lands on homepage
   📱 Mobile | 📱 Tablet | 💻 Desktop [screenshots]

✅ User opens booking modal
   📱 Mobile | 📱 Tablet | 💻 Desktop [screenshots]

✅ User fills booking form
   📱 Mobile | 📱 Tablet | 💻 Desktop [screenshots]

✅ User submits booking
   📱 Mobile | 📱 Tablet | 💻 Desktop [screenshots]

✅ User sees confirmation
   📱 Mobile | 📱 Tablet | 💻 Desktop [screenshots]
```

### Step 5: Iterate Based on Visual Feedback

- **UI Issues:** Review screenshots to spot layout problems across breakpoints
- **Functional Issues:** Check error messages and failure screenshots
- **Make Changes:** Fix code based on visual evidence
- **Redeploy & Retest:** `npm run build && wrangler pages deploy dist/`
- **Get Updated Report:** Run tests again, receive fresh screenshots

### Step 6: Merge When Ready

When tests pass and UI looks good across all breakpoints:
```bash
git checkout main
git merge feature/descriptive-name
git push origin main
```

## Adding Screenshots to New Tests

Use the `captureEmailScreenshots()` helper function in test files:

```typescript
import { test, expect } from '@playwright/test';
import { captureEmailScreenshots } from './helpers/screenshot-helper';

test('my feature test', async ({ page }) => {
  await page.goto('/my-feature');
  await page.waitForLoadState('networkidle');

  // Run assertions
  await expect(page.locator('.feature-element')).toBeVisible();

  // Capture screenshots at all breakpoints for email report
  // IMPORTANT: Test name must match the test title exactly
  await captureEmailScreenshots(page, 'my feature test');

  console.log('✅ Test passed');
});
```

**Key Points:**
- Import `captureEmailScreenshots` from `./helpers/screenshot-helper`
- Call AFTER assertions pass (captures success state)
- Test name parameter must exactly match test title
- Screenshots saved to `test-results/email-report/screenshots/`
- Reporter automatically finds and embeds them in email

## Common Testing Patterns

### Pattern 1: Landing Page Test
```typescript
test('landing page loads successfully', async ({ page }) => {
  await page.goto('/');
  await page.waitForLoadState('networkidle');

  const heroHeading = page.locator('h1.hero-headline').first();
  await expect(heroHeading).toBeVisible();

  await captureEmailScreenshots(page, 'landing page loads successfully');
});
```

### Pattern 2: Multi-Step Flow
```typescript
test('booking flow completes', async ({ page }) => {
  await page.goto('/');
  await page.click('button:has-text("Book Now")');

  // Fill form
  await page.fill('[name="pickup"]', 'Downtown Austin');
  await page.fill('[name="destination"]', 'Airport');

  // Verify final state
  await expect(page.locator('.booking-summary')).toBeVisible();

  // Capture completed flow state
  await captureEmailScreenshots(page, 'booking flow completes');
});
```

### Pattern 3: Authenticated Test (Using Fixture)
```typescript
import { test, expect } from './fixtures/auth.fixture';

test('admin dashboard displays', async ({ authenticatedPage }) => {
  await authenticatedPage.goto('/admin');
  await authenticatedPage.waitForLoadState('networkidle');

  await expect(authenticatedPage.locator('.dashboard')).toBeVisible();

  await captureEmailScreenshots(authenticatedPage, 'admin dashboard displays');
});
```

## Testing AI Features (CRITICAL)

**NEVER test AI features against localhost** - they require deployed URLs because:
- No local Anthropic API key (intentionally - security)
- Runtime environment variables only available in Cloudflare deployments
- AI endpoints require `locals.runtime.env` which doesn't exist in dev server

**Always use deployed feature branch URL:**
```bash
# 1. Deploy feature branch
npm run build
wrangler pages deploy dist/

# 2. Test against deployment
SEND_TEST_EMAILS=true PLAYWRIGHT_BASE_URL=https://feature-branch.your-project.pages.dev npm run test -- backroom-team-chat
```

## Environment Variables

Required in `.env`:
```bash
# Enable email sending
SEND_TEST_EMAILS=true

# Email configuration (should already be set)
RESEND_API_KEY=re_xxxxx
RESEND_ADMIN_EMAIL=admin@example.com

# Test credentials (for authenticated tests)
TEST_EMAIL=test@example.com
TEST_PASSWORD=testpassword
```

## Troubleshooting

### Images Show as Empty Boxes
**Cause:** Using old Resend version or wrong property name
**Check:** Verify `package.json` has `"resend": "^6.2.0"`
**Fix:** Run `npm install` if package.json was updated

### Screenshots Not Found in Email
**Cause:** Test name mismatch between test title and screenshot capture
**Fix:** Ensure exact match:
```typescript
test('landing page loads', async ({ page }) => {
  // ...
  await captureEmailScreenshots(page, 'landing page loads'); // ✅ Matches
});
```

### No Email Sent
**Cause:** `SEND_TEST_EMAILS` not set to 'true'
**Fix:** Export environment variable:
```bash
SEND_TEST_EMAILS=true npm run test
```

### Test Count Shows 0 in Email
**Cause:** Reporter timing issue (should be fixed in current implementation)
**Check:** Look for error logs from reporter
**Verify:** Check that `onTestEnd()` is synchronous

### Screenshots Timing Out
**Cause:** Page closed before screenshot capture
**Fix:** Call `captureEmailScreenshots()` DURING test execution, not in afterEach

## Best Practices

1. **Test Against Deployments for AI Features**
   - Always use `PLAYWRIGHT_BASE_URL` for features using Anthropic API
   - Deploy to feature branch first, then test
   - Never rely on localhost for AI endpoint testing

2. **Meaningful Test Names**
   - Use descriptive names that appear clearly in email
   - Keep names under 50 chars (they're used in filenames)
   - Match test title exactly in `captureEmailScreenshots()`

3. **Capture After Success**
   - Call screenshot helper after assertions pass
   - Captures the successful state, not failure state
   - For failure debugging, Playwright auto-captures on failure

4. **Limit Email Volume**
   - Only enable `SEND_TEST_EMAILS` for important runs
   - Don't send emails for every local test iteration
   - Best for: feature branch validation, CI/CD, final checks

5. **Use Validation Tests for Email System**
   - Simple tests to verify email system works
   - Example: `tests/test-email-report.spec.ts`
   - Run these first to validate setup

## Integration with Other Skills

This skill works together with:

- **add-new-feature**: After creating feature branch, use this skill to test deployment
- **quiet-build**: Use filtered build before deploying for tests
- **quiet-deploy**: Use filtered deploy to get clean URL for testing
- **debug-feature-branch**: If tests fail, use debug skill to tail deployment logs
- **beads-task-management**: Create issues for test failures discovered in email reports

## Files and Locations

**Test Infrastructure:**
- `tests/helpers/screenshot-helper.ts` - Helper function
- `src/lib/test-reporter/custom-reporter.ts` - Playwright reporter
- `src/templates/email/test-results.ts` - Email template
- `playwright.config.ts` - Reporter configuration

**Documentation:**
- `memory-bank/03-guides/automated-test-emails.md` - Complete guide
- `CLAUDE.md` - Testing section with AI feature notes

**Test Examples:**
- `tests/test-email-report.spec.ts` - Landing page validation tests
- `tests/backroom-team-chat.spec.ts` - AI feature tests

## Quick Reference

```bash
# Most common usage: Test feature branch with email report
SEND_TEST_EMAILS=true PLAYWRIGHT_BASE_URL=https://feature-xyz.your-project.pages.dev npm run test -- test-name

# Validation test (check email system works)
SEND_TEST_EMAILS=true PLAYWRIGHT_BASE_URL=https://your-project.pages.dev npm run test -- test-email-report

# Run all tests with email
SEND_TEST_EMAILS=true PLAYWRIGHT_BASE_URL=https://your-url.pages.dev npm run test

# Local testing (no email)
npm run test -- test-name
```

## Expected Output

**Console:**
```
[TestResultsEmailReporter] Test run started
📸 Captured mobile screenshot: test-name-mobile.png
📸 Captured tablet screenshot: test-name-tablet.png
📸 Captured desktop screenshot: test-name-desktop.png
✅ Test passed
[TestResultsEmailReporter] Test completed: test name - passed
[TestResultsEmailReporter] Total results collected: 1
[TestResultsEmailReporter] Results: 1 passed, 0 failed, 0 skipped
[TestResultsEmailReporter] Sending email report...
Email sent successfully, ID: [email-id]
Test results email sent to admin@example.com (1 tests, 3 screenshots)
```

**Email Subject:**
```
Test Results - 3/3 Passed (100%)
```

**Email Body:**
- Test summary with stats
- Individual test results with ✅/❌ icons
- 3 screenshots per test (mobile/tablet/desktop) displayed inline
- Neobrutalist styling with borders and shadows
- Central timezone timestamp

## Success Criteria

A successful test run with email reporting should:
1. ✅ Tests execute against correct URL (deployed or localhost)
2. ✅ Screenshots captured at all 3 breakpoints (visible in console logs)
3. ✅ Email sent successfully (console shows email ID)
4. ✅ Email arrives with correct test count and screenshot count
5. ✅ Screenshots display inline (not as empty boxes or attachments)
6. ✅ Timestamp shows Central timezone (CST/CDT)
7. ✅ Pass/fail status matches actual test results

If any criterion fails, check Troubleshooting section above.
