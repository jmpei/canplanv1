# CanPlan Flutter UI Skeleton — Design Spec

**Date:** 2026-06-02
**Status:** Approved (design); pending spec review
**Author:** Jiaming Pei

## Goal

Rebuild a **high-fidelity, UI-only skeleton** of the CanPlan iOS app (UVic
CanAssist, `canplan_2024`, v3.2.0) in Flutter. The skeleton reproduces the look
and navigation of the app's core flows using hardcoded sample data. It does
**not** implement real persistence or device-media features. It is built so the
data layer can later be swapped for a real backend without touching the UI.

## Scope

| Dimension | Decision |
|---|---|
| Build type | Pure UI skeleton — hardcoded in-memory sample data |
| Fidelity | High-fidelity replica — screenshot the real app per screen, reuse extracted PNG assets, sample colors from screenshots |
| Coverage | Core ~12 screens (main path) |
| Target platform | iOS Simulator (primary). Code stays platform-agnostic where free. |
| Toolchain | Flutter/Dart **not installed** on this machine — install is step 0. |

### Explicitly NOT in scope (YAGNI)

Real audio record/playback, text-to-speech, local notifications/alarms, real
camera/gallery picking (use placeholder images), iCloud sync, real statistics
computation, kiosk mode, tutorial/onboarding walkthrough. These get **tappable
but mocked** entry points where they sit on a core screen, so the navigation
feels complete.

## Architecture

Mirror the original `canplan_2024` `lib/` tree, but only the parts the 12
screens need. One Provider over an in-memory sample repository.

```
lib/
├── main.dart                      # MaterialApp, theme, initial route
├── models/
│   ├── task.dart                  # id, name, category, image, mood, steps[]
│   ├── step.dart                  # id, order, text, image, useRecording
│   ├── category.dart              # id, name, image
│   ├── schedule_instance.dart     # task, dueDate, status  (a concrete to-do)
│   └── repeat.dart                # interval, startDate, endDate
├── data/
│   └── sample_data.dart           # hardcoded tasks / categories / schedule
├── providers/
│   ├── task_provider.dart         # holds sample data, exposes lists + lookups
│   └── ui_state_provider.dart     # transient UI state (e.g. do-task step index)
├── theme/
│   ├── custom_colors.dart         # colors sampled from the real app
│   └── app_theme.dart             # ThemeData, fonts (NotoSansMono + icons)
├── screens/                       # the 12 screens (see table)
└── widgets/                       # default_appbar, default_bottombar,
                                   # default_button, nav_button, play_button,
                                   # task_list, categories_list, etc.
assets/
├── images/                        # reused extracted PNGs (~140)
└── sounds/                        # alarm / bell mp3s (referenced, not played)
fonts/                             # NotoSansMono, Material/Cupertino icons
```

**Data flow:** `sample_data.dart` → `TaskProvider` (ChangeNotifier) → screens
read via `context.watch`/`Provider.of`. `ui_state_provider` holds ephemeral
navigation state such as the current step index in the do-task flow. Swapping in
a real backend later means replacing the provider's data source only; screens
are untouched.

**Why this shape:** It matches the original app's Provider architecture, keeps
each screen focused and independently understandable, and makes the
later capstone extension (real storage) a drop-in. A heavier choice (loading the
bundled `Task_Sequencer.sqlite`) is rejected — it pulls in `sqflite` and
contradicts "no real storage."

## Screens (core 12)

Covers the full main path: browse → create → execute → organize → schedule →
configure.

| # | Screen | Maps to original | Notes |
|---|---|---|---|
| 1 | Dashboard (home) | `dashboard_screen` | Entry; category/task entry points |
| 2 | All Tasks list | `all_tasks_screen` | Scrollable task list w/ images |
| 3 | Categories | `categories_screen` | Category grid/list |
| 4 | New Category | `new_category_screen` | Form: name + image (placeholder) |
| 5 | New Task (+ select category) | `new_task_screen` + `new_task_select_category_screen` | Form + category picker |
| 6 | New Step | `new_step_screen` | Form: text + image + record toggle (mocked) |
| 7 | New Schedule | `new_schedule_screen` | Assign task to date/time/repeat |
| 8 | Do-Task: Start | `task_start_body` | Task intro / start button |
| 9 | **Do-Task: Step (core)** | `task_step_body` | Step-by-step guided view: image, text, play/skip/next, mood |
| 10 | Calendar / To-Do | `calendar_screen` | Date-based to-do list |
| 11 | To-Do pickers | `to_do_pick_date/time/repeat` | Bottom-sheet pickers (group) |
| 12 | Main Settings | `main_settings_screen` | Settings list; sub-pages are mocked rows |

## Sample data

Reuse the app's own demo tasks (their step images are already extracted):
**make coffee**, **wash clothes**, **charge phone**. Add 2–3 categories
(e.g. Kitchen, Laundry, Personal) and a handful of calendar to-do instances
across nearby dates.

## High-fidelity method

1. `open /Applications/CanPlan.app`, navigate, and **screenshot each of the 12
   screens** as pixel-level reference.
2. Sample colors from those screenshots into `custom_colors.dart`.
3. Copy the extracted PNGs into `assets/images/`; use the original buttons,
   mood faces, stars, arrows directly.
4. Use `NotoSansMono` (bundled in the original) for body text.

## Testing / verification

UI skeleton, so verification is visual + smoke-level:

- `flutter analyze` clean.
- App builds and launches on the iOS Simulator.
- All 12 screens reachable via in-app navigation (no dead ends; mocked entries
  navigate or no-op cleanly, never crash).
- Side-by-side screenshot comparison of each screen against the real app
  reference captures.
- Widget smoke tests: each screen builds without throwing.

## Implementation order (high level)

0. Install Flutter/Dart toolchain; `flutter create` the project; confirm it runs
   on the iOS Simulator.
1. Capture reference screenshots from the real app.
2. Theme + assets: colors, fonts, copy PNGs, wire `pubspec.yaml`.
3. Models + sample data + providers.
4. Shared widgets (appbar, bottombar, buttons, list tiles).
5. Screens, in main-path order, each matched against its reference screenshot.
6. Verification pass (analyze, launch, screen-by-screen comparison).

## Open items

- Git is not initialized in this directory. Spec is written to disk but not
  committed. Initialize a repo before/at implementation start (ask first).
- Exact color values pending screenshot sampling (step 1–2).
