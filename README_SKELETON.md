# CanPlan — Flutter UI Skeleton

A high-fidelity, **UI-only** reconstruction of the CanPlan iOS app (UVic
CanAssist) in Flutter. Hardcoded sample data; no real persistence, audio, TTS,
notifications, or iCloud. Built so the data layer can later be swapped for a real
backend without touching the screens.

Design spec: `docs/superpowers/specs/2026-06-02-canplan-flutter-ui-skeleton-design.md`

## Live demo

Every push to `main` builds the Flutter web app and publishes it to GitHub Pages
via `.github/workflows/deploy.yml`. Once enabled, the demo is live at:

```
https://<your-github-username>.github.io/<repo-name>/
```

**One-time setup** (after the first push): repo **Settings → Pages →
Build and deployment → Source → "GitHub Actions"**. The next push (or a manual
run from the Actions tab) deploys it; the URL also appears under the repo's
**Environments → github-pages**.

## Run it

```bash
export PATH="$HOME/development/flutter/bin:$PATH"     # Flutter installed here
cd "<this folder>"

flutter run -d chrome        # web (what the previews were captured on)
# or
flutter run -d macos         # native desktop window (needs CocoaPods)
```

`flutter analyze` → 0 errors (13 info-level lints remain: a couple deprecated
Radio/Switch color APIs and cosmetic underscore hints — non-blocking).
`flutter test` → the boot smoke test passes.

## Structure

```
lib/
├── main.dart                 # MaterialApp + route table (class Routes)
├── models/                   # task, task_step, category, schedule_instance, repeat
├── data/sample_data.dart     # the 3 demo tasks + categories + calendar to-dos
├── providers/                # TaskProvider (data) + UiStateProvider (do-task step index)
├── theme/                    # custom_colors (sampled from the real app) + app_theme
├── widgets/                  # DefaultAppBar, DefaultBottomBar, DefaultButton,
│                             # TaskListTile, CategoryTile
└── screens/                  # the 12 screens
assets/images/                # ~137 PNG/JPG reused from the real app bundle
fonts/NotoSansMono.ttf
```

## The 12 screens (routes)

| Route | Screen |
|---|---|
| `/` | Dashboard |
| `/all-tasks` | All Tasks list |
| `/categories` | Categories |
| `/new-category` | New Category form |
| `/new-task` | New Task form (+ inline category picker) |
| `/new-step` | New Step form |
| `/new-schedule` | Schedule a Task |
| `/do-task-start` | Do-Task: start page |
| `/do-task-step` | Do-Task: step-by-step guided flow (core) |
| `/calendar` | To-Do / Calendar |
| `/todo-pickers` | Date / Time / Repeat pickers |
| `/settings` | Main Settings |

Previews of every screen are in `preview_screenshots/` (captured on Flutter web
at 414×896 @2x).

## Not implemented (by design — mocked entry points only)

Real audio record/playback, text-to-speech, local notifications, camera/gallery
picking, iCloud sync, statistics, kiosk mode, tutorial walkthrough.
