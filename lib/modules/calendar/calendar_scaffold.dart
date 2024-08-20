import 'package:flutter/material.dart';

class CalendarScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;

  const CalendarScaffold({
    required this.title,
    required this.body,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit_calendar_outlined),
        ),
        actions: actions,
      ),
      body: body,
    );
  }
}
