---
name: dashboard-ui-theme
description: 'Design and implement clean Tailwind-style dashboard UIs using the Prize24 palette (slate neutrals + coral-to-amber gradient brand). Use for React/Vite dashboard pages, cards, tables, KPIs, charts, and responsive admin layouts with consistent color tokens and quality checks.'
argument-hint: 'What dashboard screen or component should be built?'
---

# Dashboard UI Theme Skill

## What This Skill Produces
This skill produces a polished, responsive dashboard UI implementation that follows a clean utility-first visual style and uses the required Prize24 color system consistently across layout, components, and states.

## Scope And Constraints
- Scope: workspace only in `.github/skills/dashboard-ui-theme/`.
- Token format: CSS variables in app stylesheets are required.
- Tailwind config mapping is optional, not required.

## Use This Skill When
- Building a new dashboard page or module in React.
- Refactoring an existing admin UI to a cleaner, token-driven style.
- Creating KPI cards (business outcomes), tables, filters, charts, or navigation shells.
- You want consistent visual language without drifting from the approved palette.

## Required Color Tokens
Use these exact tokens as the source of truth.

```ts
// Custom color palette based on HTML design
class _DesignColors {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);
  static const Color orange50 = Color(0xFFFFF7ED);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange500 = Color(0xFFF97316);
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color purple500 = Color(0xFF8B5CF6);
  static const Color green500 = Color(0xFF22C55E);
  static const Color yellow500 = Color(0xFFEAB308);
}
```

## Workflow
1. Clarify screen intent and data density.
Determine page type (overview, analytics, operations, settings), critical actions, and primary metrics before writing UI code.

2. Define UI tokens first.
Create or update CSS custom properties in a central stylesheet (for example, `:root` in app-level CSS) that map to the required palette.
Use naming like `--slate-50`, `--brand-start`, `--brand-end`, `--success-500`, `--warning-500`.

3. Establish page scaffolding.
Build a predictable shell:
- Header with page title, date range, and primary CTA.
- KPI row (2-6 cards) for top business metrics only.
- Main region with chart/table split.
- Secondary region for activity, alerts, or tasks.

Card discipline:
- Each card must have a unique purpose.
- Do not create slight-variant cards that repeat the same meaning.
- Avoid technical implementation labels in primary dashboard cards.

4. Use the full viewport first.
Favor wide, edge-to-edge dashboard compositions over centered narrow columns.
- Let the main dashboard shell span the available screen width on desktop.
- Reserve narrow centered layouts for auth cards, modals, and compact utility states.
- Use sticky side panels, dense card grids, and split views to make better use of horizontal space.

5. Apply clean utility-first styling.
Prefer concise classes and composable styles:
- Surfaces: slate50/slate100 backgrounds with slate200 borders.
- Text hierarchy: slate900 for headings, slate600 for body, slate500 for metadata.
- Radius: medium-large corners on cards.
- Spacing rhythm: consistent 4/8/12/16/24 scale.

Copy style:
- Use concise, professional language.
- Prefer business/admin wording over implementation details.
- Avoid explanatory prose blocks when labels and controls already communicate intent.

6. Use brand and semantic colors intentionally.
- Brand gradient (`brandStart` -> `brandEnd`) for hero accents and primary emphasis.
- `green500` for positive status, `yellow500` for warning, `orange500` for attention, `blue500` for info, `purple500` for secondary highlights.
- Avoid using semantic colors as full-page backgrounds.

7. Implement states and interactions.
Include hover, focus-visible, active, loading, empty, and error states for interactive elements.
Ensure keyboard navigation and visible focus rings.

8. Make it responsive from the start.
- Mobile: stack sections, keep KPI cards readable, avoid horizontal clipping.
- Tablet: 2-column card/table balancing.
- Desktop: full dashboard grid with stable alignment.

9. Validate quality before finishing.
Run a final pass for consistency, readability, and accessibility.

## Decision Points
- If the page is metric-heavy, prioritize dense but scannable cards/table summaries over decorative visuals.
- If tasks/actions dominate, prioritize workflow components and reduce chart prominence.
- If data is sparse, use concise empty states with one clear next action.

## Completion Checks
- All colors come from the required token set.
- UI feels clean and consistent, similar to a disciplined Tailwind dashboard style.
- No low-contrast text on tinted backgrounds.
- Keyboard focus is visible on controls.
- Layout works on mobile, tablet, and desktop.
- The main dashboard uses the available horizontal space on large screens instead of staying centered and narrow.
- KPI cards represent business/admin outcomes, not UI or implementation metadata.
- No duplicate or near-duplicate cards with slight wording differences.
- Empty/loading/error states are implemented where relevant.

## Output Format Expectations
When executing this skill, the final response should include:
- What was built and where.
- Token decisions and any reusable classes/components introduced.
- Responsive behavior summary.
- Any known tradeoffs or follow-up improvements.
