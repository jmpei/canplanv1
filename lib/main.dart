import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'providers/task_provider.dart';
import 'providers/ui_state_provider.dart';

import 'screens/dashboard_screen.dart';
import 'screens/all_tasks_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/new_category_screen.dart';
import 'screens/new_task_screen.dart';
import 'screens/new_step_screen.dart';
import 'screens/new_schedule_screen.dart';
import 'screens/do_task_start_screen.dart';
import 'screens/do_task_step_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/todo_pickers_screen.dart';
import 'screens/main_settings_screen.dart';

void main() => runApp(const CanPlanApp());

class CanPlanApp extends StatelessWidget {
  const CanPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => UiStateProvider()),
      ],
      child: MaterialApp(
        title: 'CanPlan',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        initialRoute: Routes.dashboard,
        routes: {
          Routes.dashboard: (_) => const DashboardScreen(),
          Routes.allTasks: (_) => const AllTasksScreen(),
          Routes.categories: (_) => const CategoriesScreen(),
          Routes.newCategory: (_) => const NewCategoryScreen(),
          Routes.newTask: (_) => const NewTaskScreen(),
          Routes.newStep: (_) => const NewStepScreen(),
          Routes.newSchedule: (_) => const NewScheduleScreen(),
          Routes.doTaskStart: (_) => const DoTaskStartScreen(),
          Routes.doTaskStep: (_) => const DoTaskStepScreen(),
          Routes.calendar: (_) => const CalendarScreen(),
          Routes.todoPickers: (_) => const TodoPickersScreen(),
          Routes.settings: (_) => const MainSettingsScreen(),
        },
      ),
    );
  }
}

/// Central route names. Screens that need a task read an optional task id from
/// `ModalRoute.of(context)!.settings.arguments` and fall back to the first
/// sample task, so every route renders standalone (good for screenshots).
class Routes {
  Routes._();
  static const dashboard = '/';
  static const allTasks = '/all-tasks';
  static const categories = '/categories';
  static const newCategory = '/new-category';
  static const newTask = '/new-task';
  static const newStep = '/new-step';
  static const newSchedule = '/new-schedule';
  static const doTaskStart = '/do-task-start';
  static const doTaskStep = '/do-task-step';
  static const calendar = '/calendar';
  static const todoPickers = '/todo-pickers';
  static const settings = '/settings';
}
