import 'package:calendar_v2/modules/user/login/login_presenter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  final LoginPresenter _presenter = LoginPresenter();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: FilledButton(
          onPressed: () {
            _presenter.login();
            context.go('/tasks/calendar');
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}
