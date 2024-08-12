import 'package:flutter/material.dart';

class CalendarManagerView extends StatelessWidget {
  const CalendarManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calendars")),
      body: const Placeholder(),
    );
  }
}
