# CanPlan.app — Reconstructed Project Structure

> Reverse-engineered from the installed binary at `/Applications/CanPlan.app`.
> The Dart source is AOT-compiled into `App.framework/App` (8.6 MB arm64 Mach-O),
> so **actual source code is not recoverable** — only the file/folder layout,
> bundled assets, database schema, and dependency list below, recovered from
> symbol strings and the app bundle.

## App identity

| | |
|---|---|
| Display name | **CanPlan** |
| Publisher | University of Victoria — **CanAssist** |
| Bundle ID | `com.canassist.TaskManager` |
| Version | **3.2.0** (min iOS 13.0) |
| Category | Productivity |
| Distribution | iOS app, wrapped to run on Apple Silicon macOS (`Wrapper/Runner.app`) |
| Framework | **Flutter / Dart**, internal package `canplan_2024` |
| State mgmt | Provider (`providers/`) |
| Local storage | SQLite (Core Data–style schema, bundled `Task_Sequencer.sqlite`) |
| Crash reporting | Sentry (disabled by default in `.env`) |

## Dart source tree (`lib/`)

Reconstructed from `package:canplan_2024/...` symbols. 55 Dart files.

```
lib/
├── main.dart
├── database_helper.dart            # SQLite access layer
├── preference_manager.dart         # shared_preferences wrapper
├── navigation_service.dart         # global navigator key / routing
├── task_timer_manager.dart         # timing logic while doing a task
│
├── models/
│   ├── task_model.dart
│   ├── step_model.dart
│   ├── schedule_model.dart
│   ├── repeat_model.dart
│   └── category_model.dart
│
├── providers/
│   ├── task_provider.dart
│   └── ui_state_provider.dart
│
├── screens/
│   ├── dashboard_screens/
│   │   ├── dashboard_screen.dart
│   │   └── all_tasks_screen.dart
│   ├── add_task_screens/
│   │   ├── new_task_screen.dart
│   │   ├── new_task_select_category_screen.dart
│   │   ├── new_step_screen.dart
│   │   └── new_schedule_screen.dart
│   ├── do_task_screens/            # step-by-step task guidance flow
│   │   ├── task_screen.dart
│   │   ├── task_start_body.dart
│   │   └── task_step_body.dart
│   ├── categories_screens/
│   │   ├── categories_screen.dart
│   │   └── new_category_screen.dart
│   ├── to_do_list_screens/
│   │   ├── calendar_screen.dart
│   │   ├── to_do_pick_task.dart
│   │   ├── to_do_pick_date.dart
│   │   ├── to_do_pick_time.dart
│   │   └── to_do_pick_repeat.dart
│   ├── settings_screens/
│   │   ├── main_settings_screen.dart
│   │   └── settings_subscreens/
│   │       ├── audio_speech_settings_screen.dart
│   │       ├── notifications_settings_screen.dart
│   │       ├── interface_settings_screen.dart
│   │       ├── icloud_settings_screen.dart
│   │       └── statistics_screen.dart
│   ├── tutorial_screen.dart
│   ├── info_page_screen.dart
│   └── feedback_screen.dart
│
├── util/
│   ├── background_processes.dart   # workmanager background tasks
│   ├── bottom_sheet_service.dart
│   └── custom_colors.dart
│
└── widgets/
    ├── animations/
    │   └── custom_page_transition.dart
    ├── categories_list/
    │   └── categories_list.dart
    ├── task_list/
    │   ├── task_list.dart
    │   └── limited_dismissible.dart
    ├── interactables/
    │   ├── default_appbar.dart
    │   ├── default_bottombar.dart
    │   ├── default_button.dart
    │   ├── nav_button.dart
    │   ├── play_button.dart
    │   ├── save_menu_appbar.dart
    │   ├── acknowledge_dialogue.dart
    │   └── kiosk_navbar.dart
    ├── todo_list_listtile_widget.dart
    ├── load_tasks_dialogue.dart
    ├── tutorial_screen_widget.dart
    └── tutorial_screen_widget.dart
```

## Bundled SQLite schema (`assets/Task_Sequencer.sqlite`)

Core Data legacy schema (`Z`-prefixed tables, `Z_PK` keys) — indicates the data
model was migrated from an earlier native iOS Core Data app into the Flutter
rewrite.

```
ZTASK              Z_PK, ZACTIVE, ZDISPLAYORDER, ZMOOD, ZSAMPLETASK,
                   ZTASKTOCATEGORY, ZNAME, ZFULLIMAGE(blob), ZIMAGE(blob)

ZSTEP              Z_PK, ZDISPLAYORDER, ZUSERECORDING, ZSTEPTOTASK,
                   ZLOCALURL, ZTEXT, ZVIDEOURL, ZIMAGE(blob), ZTHUMBNAIL(blob)

ZCATEGORY          Z_PK, ZDISPLAYORDER, ZNAME, ZIMAGE(blob)

ZSCHEDULEPARTICLE  Z_PK, ZSTATUS, ZSCHEDULEPARTICLETOTASK,
                   ZCOMPLETEDDATE, ZDUEDATE, ZLOCALURL          # a scheduled instance of a task

ZREPEAT            Z_PK, ZDISPLAYORDER, ZREPEATTOTASK,
                   ZSTARTDATE, ZENDDATE, ZREPEATINTERVAL        # recurrence rule

ZSTATISTICS        Z_PK, ZDAYSTODOLOADED, ZSTEPSVIEWED, ZTASKSCOMPLETED,
                   ZINSTALLDATE, ZTIMEACTIVE, ZTODODAILYPOINTAWARDEDLASTON

ZACHIEVEMENT       Z_PK, ZNAME, ZDESCRIPTIONTEXT               # gamification badges
ZINFORMATION       Z_PK, ZLASTUPDATEDATE
Z_METADATA / Z_PRIMARYKEY / Z_MODELCACHE                        # Core Data internals
```

**Relationships:** `Task` 1—N `Step`, `Task` N—1 `Category`,
`Task` 1—N `ScheduleParticle` (concrete to-do instances), `Task` 1—N `Repeat`.

## Assets

- **`assets/images/`** — ~140 PNGs: navigation/control buttons (play/pause/stop/
  skip/record/speak), mood faces (happy/sad/plain/ok), star rewards
  (bronze/silver/gold), arrows, CanAssist logo, legacy iOS launch images, plus
  sample tasks (`sample_task_images/`: make coffee, wash clothes, charge phone).
- **`assets/sounds/`** — `alarm.mp3`, `singlebell.mp3`, `extendedbell.mp3`.
- **`assets/documentation/CanPlanManual2024.pdf`** — in-app user manual.
- **`assets/Task_Sequencer.sqlite`** — seed database (sample tasks + schema).
- **Fonts** — MaterialIcons, NotoSansMono, CupertinoIcons.
- `shaders/ink_sparkle.frag` — stock Flutter Material ink shader.

## Flutter plugin dependencies (from `Frameworks/`)

| Capability | Plugin(s) |
|---|---|
| Local database | `sqflite_darwin` |
| Preferences | `shared_preferences_foundation` |
| File paths | `path_provider_foundation` |
| Audio record/play | `flutter_sound_core`, `audioplayers_darwin`, `audio_session` |
| Ringtones / alarms | `flutter_ringtone_player` |
| Local notifications | `flutter_local_notifications` |
| Background tasks | `workmanager` |
| Camera / gallery | `image_picker_ios` |
| Video | `video_player_avfoundation`, `video_thumbnail` |
| PDF viewing | `flutter_pdfview`, `pdfx` |
| iCloud sync | `icloud_storage` |
| Device / app info | `device_info_plus`, `package_info_plus` |
| Permissions | `permission_handler_apple` |
| Image codec | `libwebp` |
| Crash reporting | `Sentry`, `sentry_flutter` |

## Build-time config (`flutter_assets/.env`)

```
ENABLE_TUTORIAL=false      DEFAULT_NOTIFICATIONS=true    DEBUG=false
STRESS=false  STRESS_NUMBER=50  RANDOM_SEED=1
EXPERIMENTAL_UI=true       KIOSK_MODE=false              SENTRY_ERROR_REPORTING=false
SENTRY_DSN=<present>       # public-by-design; reporting disabled
```

## iOS permission usage strings (`Info.plist`)

Camera, Microphone, Photo Library (read + add), Documents folder, and
**Speech Recognition** ("read task steps aloud") — consistent with an
accessibility / assistive task-guidance app for users with cognitive or memory
challenges.

---

## What this app does (inferred)

CanPlan is an **assistive step-by-step task manager**: a caregiver/user creates
**Tasks** organized by **Category**, each broken into ordered **Steps** (with
text, image, audio recording, or video). Tasks are scheduled onto a calendar as
**to-do instances** with optional **recurrence**, fire **notifications/alarms**,
and are completed one step at a time in a guided "do task" flow with audio
playback, text-to-speech, mood feedback, and **star/achievement gamification**.
A **kiosk mode** locks the UI down for the end user.

> ⚠️ The reconstruction is structural only. File/folder names and the DB schema
> are exact; the *behavior* descriptions are inferred from names + bundled assets
> and are not verified against source.
