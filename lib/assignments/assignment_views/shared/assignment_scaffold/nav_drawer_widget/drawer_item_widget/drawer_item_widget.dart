import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  final void Function() onPressed;

  const DrawerItemWidget({
    required this.title,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(24.0),
        shape: const RoundedRectangleBorder(),
        foregroundColor: Colors.grey[800],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 16.0),
          Text(title),
        ],
      ),
    );
  }
}
