import 'package:calendar_v2/assignments/course_manager/course_manager_view.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_scaffold/nav_drawer_widget/drawer_item_widget/drawer_item_widget.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_scaffold/nav_drawer_widget/user_header_widget/user_header_widget.dart';
import 'package:flutter/material.dart';

class NavDrawerWidget extends StatelessWidget {
  const NavDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        const UserHeaderWidget(),
        DrawerItemWidget(
          title: 'Manage Courses',
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CourseManagerView(),
              ),
            );
          },
        ),
      ],
    );
  }
}
