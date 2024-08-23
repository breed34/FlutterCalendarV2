import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:calendar_v2/routes.dart';
import 'package:calendar_v2/theme.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (const String.fromEnvironment('env') == 'local') {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  FirebaseUIAuth.configureProviders([
    GoogleProvider(clientId: const String.fromEnvironment('googleClientId')),
  ]);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      initialRoute: initialRoute,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
