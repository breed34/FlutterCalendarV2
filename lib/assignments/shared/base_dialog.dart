import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final Widget content;

  const BaseDialog({
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).pop();
        },
        child: GestureDetector(
          onTap: () {},
          child: Dialog(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              constraints: const BoxConstraints(
                maxWidth: 400.0,
                maxHeight: 600.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 8.0),
                  content,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
