# Mew Browser Testing Skill

Guide for testing Mew (mew.ideaflow.app) using browser-tools.

## Core Concept: Programmatic Interaction Mapping

Human UI interactions don't always translate directly to programmatic equivalents. This skill documents the **translation layer** - how to achieve each user action via browser-tools/Playwright.

| Human Action | Programmatic Equivalent | Notes |
|--------------|------------------------|-------|
| Click triangle to expand | Click child count number | Direct triangle click doesn't propagate |
| Type in search box | React native setter pattern | See "Search Input" section below |
| Click node text | Enters edit mode | Not useful for navigation |
| Hover node | Shows action icons | Zoom, link, star icons appear |
| Click zoom icon | PointerEvent on SetRootButton | Must use `pointerdown`, not `click` |
| Navigate to node | PointerEvent on zoom button | See "Zoom to Node" section below |

Each feature test may require discovering its own workaround. Document findings here as they're discovered.

## Setup

### ⚠️ CRITICAL: Always Launch Chrome in tmux

**NEVER start Chrome directly from the agent.** It will crash when the session ends.

```bash
# Kill existing browser session
tmux kill-session -t browser 2>/dev/null

# Launch Chrome in tmux with mew@ideaflow.io profile
sudo -u alex-work tmux new-session -d -s browser \
  'DISPLAY=:1 google-chrome \
    --remote-debugging-port=9222 \
    --user-data-dir=/home/alex-work/.config/google-chrome \
    --profile-directory="Profile 3" \
    --no-first-run'

# Wait for Chrome to start
sleep 3

# Verify remote debugging is available
curl -s http://localhost:9222/json/version
```

### Profile Locations

| Profile | Path | Account |
|---------|------|---------|
| Profile 3 | `/home/alex-work/.config/google-chrome/Profile 3/` | mew@ideaflow.io |
| Backup | `/home/alex-work/.config/google-chrome-backup-mew-ideaflow/` | Backup of above |

### Display Configuration

- alex-work uses DISPLAY=:1
- alex uses DISPLAY=:9

### Navigate to Mew

```bash
# After Chrome is running in tmux:
browser-nav.js "https://mew.ideaflow.app/nonlinear"
```

## Key Interaction Patterns

### Expand/Collapse Nodes

**The triangle (▶) is NOT the expand trigger.** Click the **child count number** instead.

```javascript
// Expand a node by clicking its child count
browser-eval.js "(() => {
  const targetText = 'Global Brain';
  const allElements = document.body.querySelectorAll('*');
  
  for (const el of allElements) {
    // Find count elements (just numbers, no children)
    if (/^\\d+$/.test(el.textContent?.trim()) && el.children.length === 0) {
      // Walk up to check if near target node
      let parent = el.parentElement;
      for (let i = 0; i < 10; i++) {
        if (parent?.textContent?.includes(targetText) && parent.textContent.length < 200) {
          el.click();
          return 'expanded ' + targetText;
        }
        parent = parent?.parentElement;
      }
    }
  }
  return 'not found';
})()"
```

### Visual Debugging

When struggling to find elements, add visual markers:

```javascript
browser-eval.js "(() => {
  const selectors = [
    '[class*=RelatedObjectLeftClickArea]',
    '[class*=ToggleButton]',
    '[class*=LeftHandler]'
  ];
  
  let count = 0;
  for (const sel of selectors) {
    document.querySelectorAll(sel).forEach(el => {
      el.style.border = '2px solid red';
      el.style.backgroundColor = 'rgba(255,0,0,0.2)';
      count++;
    });
  }
  return 'marked ' + count + ' elements';
})()"
```

Then take a screenshot to see what's highlighted.

### Zoom to Node (Navigate Into)

**Key insight:** The zoom button uses `onPointerDown`, not `onClick`. Must dispatch `PointerEvent`:

```javascript
browser-eval.js "(() => {
  const targetNode = 'Global Brain';
  const buttons = document.querySelectorAll('.RelatedObjectView_SetRootButton__BTbaW');
  
  for (let i = 0; i < buttons.length; i++) {
    let parent = buttons[i].parentElement;
    for (let j = 0; j < 10; j++) {
      if (parent?.textContent?.includes(targetNode) && parent.textContent.length < 100) {
        const evt = new PointerEvent('pointerdown', {
          bubbles: true,
          cancelable: true,
          view: window,
          button: 0,
          buttons: 1,
          pointerId: 1,
          pointerType: 'mouse',
          isPrimary: true
        });
        buttons[i].dispatchEvent(evt);
        return 'Navigating to ' + targetNode;
      }
      parent = parent?.parentElement;
    }
  }
  return 'not found';
})()"
```

**Why this works:** React handlers vary - check `__reactProps$*` on DOM elements to see the actual handler type. This button has `onPointerDown`, not `onClick`, so MouseEvents are ignored.

### Search Input (React Controlled)

Search works without authentication using the React native setter pattern:

```javascript
browser-eval.js "(() => {
  const searchInput = document.querySelector('input[type=search]');
  searchInput.focus();
  
  // Use native setter to bypass React's controlled input
  const nativeSetter = Object.getOwnPropertyDescriptor(
    window.HTMLInputElement.prototype, 'value'
  ).set;
  nativeSetter.call(searchInput, 'search term');
  
  // Dispatch input event to trigger React state update
  searchInput.dispatchEvent(new Event('input', { bubbles: true }));
  
  return 'typed: ' + searchInput.value;
})()"
```

Press Enter to select first result and navigate:
```javascript
searchInput.dispatchEvent(new KeyboardEvent('keydown', { 
  key: 'Enter', code: 'Enter', keyCode: 13, bubbles: true 
}));
```

### Finding Elements by Text Content

```javascript
// Find element containing specific text and get its structure
browser-eval.js "(() => {
  const walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT);
  let node;
  while (node = walker.nextNode()) {
    if (node.textContent.trim() === 'Target Text') {
      let parent = node.parentElement;
      let path = [];
      for (let i = 0; i < 5; i++) {
        path.push(parent?.className?.split(' ')[0] || parent?.tagName);
        parent = parent?.parentElement;
      }
      return path.join(' -> ');
    }
  }
  return 'not found';
})()"
```

## Mew DOM Structure

Mew uses CSS modules with hashed class names. Use partial matches:

| Purpose | Selector Pattern |
|---------|------------------|
| Node rows | `[class*=RelatedObjectView_RelatedObjectNode]` |
| Node content | `[class*=RelatedNodeView_Container]` |
| Editor wrapper | `[class*=Editor_EditorWrapper]` |
| Left click area | `[class*=RelatedObjectLeftClickArea]` |
| Sidebar toggle | `[class*=SidebarToggle]` |

### Parent-Child Relationships

```
RelatedObjectView_RelatedObjectNode
  └── RelatedObjectView_RelatedObjectNodeContent  
      └── RelatedObjectView_NodeContentWrapper
          └── RelatedNodeView_Container
              └── RelatedNodeView_ColumnContainer
                  └── RelatedNodeView_FlexContainer
                      └── Editor_EditorWrapper
                          └── Editor_ContentEditable (the actual text)
```

## Authentication State

### Unauthenticated
- `contenteditable="false"`, `aria-readonly="true"`
- "Sign in" button in top right
- Can browse, expand nodes, search, and switch views
- Cannot edit or create nodes

### Authenticated  
- Full editing capabilities
- Search functional
- AI agent available

## Common Gotchas

1. **Profile sync required** - After creating a new Chrome profile, must sync to cache:
   ```bash
   sudo -u alex-work bash -c 'rsync -a ~/.config/google-chrome/ ~/.cache/scraping/'
   ```

2. **Wait for profile picker** - Don't navigate until profile is selected in VNC

3. **React controlled inputs** - Use native setter for form inputs:
   ```javascript
   const nativeSetter = Object.getOwnPropertyDescriptor(
     window.HTMLInputElement.prototype, 'value'
   ).set;
   nativeSetter.call(input, 'new value');
   input.dispatchEvent(new Event('input', { bubbles: true }));
   ```

4. **CSS module hashes change** - Never rely on full class names, always use `[class*=Pattern]`

5. **Puppeteer page.screenshot() changes viewport** - Using `page.screenshot()` directly sets viewport to 800x600, breaking the UI. Always reset after:
   ```javascript
   await page.setViewport({ width: 1600, height: 900 });
   ```
   Or use `browser-screenshot.js` which doesn't have this issue.

## Feature Test Checklist

Run from feature_list.json. Current status:

- [x] nav-001: Home/root view
- [x] nav-002: URL slug routing (via search + Enter)
- [x] nav-003: Expand/collapse nodes (click count number)
- [x] nav-004: Zoom to node (PointerEvent on SetRootButton)
- [x] nav-005: Browser back/forward history
- [x] search-001: Search by keyword (React native setter)
- [x] views-001: Stream view toggle
- [ ] ... (127+ more features)

**7 features validated without authentication.**

## Related

- Linear: ENT-5038 (testing issue)
- Branch: `alexg/playwright-testing`
- Feature spec: `feature_list.json` (134 features)
