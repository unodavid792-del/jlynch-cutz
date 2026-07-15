# Streamlined Web Template

A high-performance, context-efficient vanilla HTML, CSS, and JS project template optimized for developer speed and AI pair programming.

This template is designed specifically to help you build or recreate any live website using the minimum amount of token context, keeping your environment fast and cheap to run while yielding premium design results.

---

## Folder Structure

```text
streamlined-web-template/
├── index.html        # Clean semantic HTML layout with pre-configured viewport & meta tags
├── style.css         # Premium custom CSS variables, design tokens, light/dark themes, and animations
├── app.js            # Lightweight modular JavaScript for theme switching & interactivity
├── AGENTS.md         # Guidelines for AI coding agents to ensure minimal context bloat
├── scripts/
│   ├── fetch-page.ps1 # Utility script to fetch a target website and optimize it for LLM reading
│   ├── serve.ps1     # Starts a local web server (using Python or Node)
│   └── verify.ps1    # Performs integrity and basic structural checks on files
└── reference/        # (Auto-created) Target website source files for reference
```

---

## Getting Started

### 1. Run the Verification Checks
To make sure all files are in place and valid:
```powershell
powershell ./scripts/verify.ps1
```

### 2. Copy/Clone a Target Website
If you want to clone an existing live website:
1. Run the fetch page utility with the target website URL:
   ```powershell
   powershell ./scripts/fetch-page.ps1 -Url "https://example.com"
   ```
2. This creates:
   *   `reference/target-page.html`: The raw HTML.
   *   `reference/target-text-structure.txt`: A context-optimized, cleaned version with all massive CSS style sheets, inline scripts, SVG shapes, and comments stripped.
3. Your AI coding agent can read `reference/target-text-structure.txt` to replicate the site's layout and content with **80-90% less context usage** than scraping tools or standard file reads.

### 3. Run the Local Development Server
To launch your server:
```powershell
powershell ./scripts/serve.ps1
```
The site will run on [http://localhost:8000](http://localhost:8000).

---

## Cloning Strategy (Rules for AI Agents)
To keep the code clean and context minimal:
*   **Do not copy-paste raw CSS/JS.** Translate design styles into CSS Custom Properties (variables) in `style.css` and recreate styles cleanly.
*   **Keep JavaScript simple.** Write interactive components in clean, modern vanilla JS in `app.js`. Avoid large external libraries unless absolutely necessary.
*   **Step-by-Step.** Recreate the site section-by-section, starting from the header down to the footer, verifying the output regularly.
