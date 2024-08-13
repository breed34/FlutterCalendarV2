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
    return AlertDialog(
      title: Text(title),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      scrollable: true,
      content: content,
    );
  }
}
