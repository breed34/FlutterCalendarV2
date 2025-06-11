import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHeaderWidget extends StatelessWidget {
  const UserHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(color: Colors.blue[300]),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: ClipRect(
              child: FractionalTranslation(
                translation: const Offset(-0.2, -0.15),
                child: Icon(
                  Icons.person,
                  color: Colors.blue[100],
                  size: 160.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  FirebaseAuth.instance.currentUser!.displayName ??
                      FirebaseAuth.instance.currentUser!.email!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                FilledButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                  child: const Text('Sign Out'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
