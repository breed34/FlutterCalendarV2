import 'package:calendar_v2/modules/tasks/calendar_manager_drawer/calendar_manager_drawer.dart';
import 'package:calendar_v2/modules/tasks/task_calendar/task_calendar_view.dart';
import 'package:calendar_v2/modules/tasks/task_prioritizer/task_prioritizer_view.dart';
import 'package:calendar_v2/modules/user/login/login_view.dart';
import 'package:calendar_v2/modules/user/register/register_view.dart';
import 'package:go_router/go_router.dart';

var router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/login',
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterView(),
    ),
    GoRoute(
      path: '/tasks/calendar',
      builder: (context, state) => const TaskCalendarView(),
    ),
    GoRoute(
      path: '/tasks/prioritizer',
      builder: (context, state) => TaskPrioritizerView(),
    ),
  ],
  onException: (context, state, router) {
    router.go('/');
  },
);
