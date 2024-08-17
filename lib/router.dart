import 'package:calendar_v2/modules/calendar/calendar_manager/calendar_manager_view.dart';
import 'package:calendar_v2/modules/calendar/tasks/task_calendar/task_calendar_view.dart';
import 'package:calendar_v2/modules/calendar/tasks/task_prioritizer/task_prioritizer_view.dart';
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
      path: '/calendar',
      builder: (context, state) => CalendarManagerView(),
    ),
    GoRoute(
      path: '/tasks/calendar',
      builder: (context, state) => TaskCalendarView(),
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
