import 'package:calendar_v2/assignments/assignment_views/assignment_calendar/assignment_calendar_view.dart';
import 'package:calendar_v2/assignments/assignment_views/assignment_prioritizer/assignment_prioritizer_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

var initialRoute = FirebaseAuth.instance.currentUser == null
    ? '/login'
    : '/assignments/calendar';

var routes = {
  '/login': (BuildContext context) => SignInScreen(
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            Navigator.pushReplacementNamed(context, '/assignments/calendar');
          })
        ],
      ),
  '/assignments/calendar': (BuildContext context) => AssignmentCalendarView(),
  '/assignments/prioritizer': (BuildContext context) =>
      AssignmentPrioritizerView(),
};
