import 'package:calendar_v2/modules/user/login/login_view.dart';
import 'package:calendar_v2/routes.dart';
import 'package:calendar_v2/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: routes,
    );
  }
}
