import 'package:calendar_v2/modules/user/register/register_presenter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatelessWidget {
  final RegisterPresenter _presenter = RegisterPresenter();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Center(
        child: FilledButton(
          onPressed: () {
            _presenter.register();
            context.go('/tasks/calendar');
          },
          child: const Text("Register"),
        ),
      ),
    );
  }
}
