# Agent Instructions: Streamlined Website Cloning & Development

You are an AI coding assistant tasked with building or customizing this website by referencing or cloning a target live website. To minimize context usage and keep the development process extremely clean, modular, and fast, you MUST follow these guidelines.

---

## 1. Context Window Budgeting

*   **Do Not Read Giant Minified Files:** If the target website has minified JS or CSS files, **never** read them entirely into your context. Ask the user for specific sections or inspect elements dynamically.
*   **Segmented Reading:** Use `view_file` with explicit `StartLine` and `EndLine` parameters to read only the sections of HTML/CSS/JS that you are currently editing.
*   **Minimize NPM Dependencies:** Build with vanilla HTML5, modern CSS, and plain JavaScript. Avoid introducing heavy frameworks (React, Vue, Tailwind) unless explicitly requested.

---

## 2. Live Website Cloning Workflow

When replicating a live website, do **not** copy-paste raw, compiled, or minified source code directly. Instead, follow this **Clean Re-implementation** protocol:

1.  **Analyze Structure First:**
    *   Use tool `read_url_content` or fetch the target URL's HTML.
    *   Look at the semantic tag hierarchy (`<header>`, `<main>`, `<section>`, `<footer>`, `<form>`).
    *   Recreate the clean HTML skeleton first in `index.html`.
2.  **Extract Style Intent:**
    *   Do not copy-paste 10,000 lines of minified CSS.
    *   Identify the target design tokens: color palette (primary, secondary, background, text HSL/HEX values), typography fonts, card spacing, and layouts (Flexbox/Grid).
    *   Implement these design tokens as CSS variables at the top of `style.css`, then write clean, semantic rules using those variables.
3.  **Translate Interactive Logic:**
    *   Identify target interactive widgets (e.g., navbar toggles, slider/carousel, tabs, modal popups).
    *   Write minimal, clean event listeners and logic in `app.js` using modern vanilla JS APIs (e.g., `querySelector`, `classList`, `addEventListener`).
    *   Do not import heavy libraries (jQuery, bootstrap.js) for simple animations or state toggles.

---

## 3. Step-by-Step Execution Checklist

*   Always create a task checklist (`task.md`) in the agent workspace before making changes.
*   Work on one component or section at a time (e.g., Header first, Hero second, etc.).
*   Run the verification script `scripts/verify.ps1` after every component change to ensure no syntax errors or breaking changes were introduced.
