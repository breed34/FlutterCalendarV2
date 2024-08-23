import 'package:calendar_v2/tasks/task_views/task_calendar/task_calendar_view.dart';
import 'package:calendar_v2/tasks/task_views/task_prioritizer/task_prioritizer_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

var initialRoute =
    FirebaseAuth.instance.currentUser == null ? '/login' : '/tasks/calendar';

var routes = {
  '/login': (BuildContext context) => SignInScreen(
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            Navigator.pushReplacementNamed(context, '/tasks/calendar');
          })
        ],
      ),
  '/tasks/calendar': (BuildContext context) => TaskCalendarView(),
  '/tasks/prioritizer': (BuildContext context) => TaskPrioritizerView(),
};
