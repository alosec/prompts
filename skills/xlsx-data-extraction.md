---
name: XLSX Data Extraction
description: Extract, filter, and transform data from Excel spreadsheets. Activate when user mentions xlsx, excel sheet, spreadsheet tabs, extract data from excel, parse spreadsheet, convert spreadsheet to json/csv, or needs to work with .xlsx files programmatically.
allowed-tools: Bash, Write
---

# XLSX Data Extraction

Extract and transform data from Excel (.xlsx) files using Node.js and the xlsx library.

## When to Use

Activate whenever the user asks to:
- Extract data from specific Excel sheet tabs
- Filter spreadsheet data by date, chapter, or other criteria
- Convert Excel data to JSON, CSV, or structured format
- Parse formulas or raw values from spreadsheets
- Work with multi-sheet workbooks
- Transform Excel serial dates to human-readable formats

## Key Insights from Testing

**CRITICAL: Bash Escaping Rules for Node.js Scripts**

When running Node.js inline with bash here-documents, follow these escaping rules:

1. **Use ENDSCRIPT for here-document delimiter** (not single quotes):
   ```bash
   cat > /tmp/script.js << 'ENDSCRIPT'
   // JavaScript code here
   ENDSCRIPT
   ```

2. **Template literals in bash need special handling**:
   - ✅ GOOD: Use `+` string concatenation instead: `'Date: ' + event.date`
   - ❌ BAD: Avoid template literals: `` `Date: ${event.date}` ``

3. **Array/object access use bracket notation**:
   - ✅ GOOD: `entry[0]`, `row[2]`, `object.property`
   - ❌ BAD: Avoid complex expressions in template strings

4. **forEach callbacks must work with bash escaping**:
   - ✅ GOOD: `data.forEach((row, i) => { ... })`
   - ❌ BAD: Complex arrow functions with template literals

## Step 1: Install xlsx Library

First, ensure Node.js and npm are available:

```bash
node --version && npm --version
```

Then install xlsx in a working directory (temp or project):

```bash
cd /tmp && npm install xlsx -q
```

**Why /tmp?** The xlsx library is installed locally in `/tmp/node_modules/`, making it available for that session without polluting your project.

## Step 2: Create Extraction Script

Create a Node.js file (outside bash) that will:
1. Load the xlsx workbook
2. Extract the target sheet
3. Filter/transform data as needed
4. Output results

**Template Structure:**

```bash
cat > /tmp/extract-data.js << 'ENDSCRIPT'
const XLSX = require('xlsx');

// Load workbook
const wb = XLSX.readFile('/path/to/file.xlsx');

// List available sheets
console.log('Sheets: ' + wb.SheetNames.join(', '));

// Get specific sheet
const ws = wb.Sheets['Sheet Name'];
const data = XLSX.utils.sheet_to_json(ws, { header: 1 });

// Process data
const results = [];
for (let i = 1; i < data.length; i++) {
  const row = data[i];
  if (!row || row.length === 0) continue;

  // Extract and transform
  results.push({
    column1: row[0],
    column2: row[1],
    column3: row[2]
  });
}

// Output
console.log('Total: ' + results.length);
results.forEach(item => {
  console.log(JSON.stringify(item));
});
ENDSCRIPT
cd /tmp && node /tmp/extract-data.js
```

## Step 3: Handle Excel Date Serial Numbers

Excel stores dates as serial numbers (days since 1900-01-01). Convert them:

```javascript
function excelDateToJSDate(excelDate) {
  if (!excelDate) return null;
  const date = new Date((excelDate - 25569) * 86400 * 1000);
  return date.toISOString().split('T')[0];
}

// Usage in data processing
const jsDate = excelDateToJSDate(row[2]);
if (jsDate && jsDate.startsWith('2025-05')) {
  // This is a May 2025 event
}
```

## Step 4: Filter and Transform Results

Common filtering patterns:

**By Date Range:**
```javascript
const filtered = data.filter(row => {
  const jsDate = excelDateToJSDate(row[2]);
  return jsDate && jsDate.startsWith('2025-05');
});
```

**By Column Value:**
```javascript
const filtered = data.filter(row => row[3] === 'Austin');
```

**Group By Column:**
```javascript
const grouped = {};
data.forEach(row => {
  const key = row[3]; // chapter column
  if (!grouped[key]) grouped[key] = [];
  grouped[key].push(row);
});
```

## Best Practices

1. **Always check data length**: Empty rows are common in Excel; skip with `if (!row || row.length === 0) continue;`

2. **Use header: 1 mode**: `sheet_to_json(ws, { header: 1 })` returns arrays, not objects (more flexible for formulas)

3. **Test with small samples first**: Extract first 20 rows to verify structure before full processing

4. **Handle missing data**: Excel cells can be null/undefined; check before accessing

5. **Sort results**: Use `sort((a, b) => ...)` for predictable output

6. **Validate sheet names**: Always check `wb.SheetNames.includes('Sheet Name')` before accessing

7. **For complex transformations**: Keep data processing in Node.js, not in bash

## Common Patterns

### Extract and Display Results
```javascript
results.forEach(item => {
  console.log('Title: ' + item.title);
  console.log('Date: ' + item.date);
  console.log();
});
```

### Generate Summary Statistics
```javascript
const summary = {};
results.forEach(item => {
  if (!summary[item.chapter]) summary[item.chapter] = 0;
  summary[item.chapter]++;
});

Object.entries(summary).forEach(entry => {
  console.log(entry[0] + ': ' + entry[1]);
});
```

### Output as JSON
```javascript
console.log(JSON.stringify(results, null, 2));
```

## Integration with Other Skills

This skill works with:
- **quiet-build**: Filter build output to focus on errors
- **quiet-deploy**: Monitor deployment logs
- **testing**: Extract test data from Excel test case sheets

## Troubleshooting

**Error: Cannot find module 'xlsx'**
- Solution: Run `cd /tmp && npm install xlsx -q` before script execution

**Template literal errors in bash output**
- Solution: Use string concatenation with `+` instead of template literals

**Dates showing as wrong values**
- Solution: Verify Excel serial date formula: `(excelValue - 25569) * 86400 * 1000` milliseconds

**Sheet not found**
- Solution: First list all sheets with `console.log(wb.SheetNames)` to verify exact name
