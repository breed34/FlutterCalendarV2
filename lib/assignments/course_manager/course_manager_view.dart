import 'package:calendar_v2/assignments/course_manager/dialogs/file_upload_dialog/file_upload_dialog.dart';
import 'package:calendar_v2/server/models/course.dart';
import 'package:calendar_v2/assignments/course_manager/dialogs/add_course_dialog/add_course_dialog.dart';
import 'package:calendar_v2/assignments/course_manager/course_manager_presenter.dart';
import 'package:calendar_v2/assignments/course_manager/dialogs/edit_course_dialog/edit_course_dialog.dart';
import 'package:flutter/material.dart';

class CourseManagerView extends StatelessWidget {
  final CourseManagerPresenter _presenter = CourseManagerPresenter();
  late final Future<void> _ensureCoursesLoaded;

  CourseManagerView({super.key}) {
    _ensureCoursesLoaded = _presenter.ensureCoursesLoaded();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Courses"),
        actions: [
          IconButton(
            onPressed: () {
              _openUploadDialog(context);
            },
            icon: const Icon(Icons.upload_outlined),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: FutureBuilder(
        future: _ensureCoursesLoaded,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 16.0),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<List<Course>>(
                      stream: _presenter.getCourses(),
                      builder: (context, sSnapshot) {
                        return ListView(
                          children: _buildCourseTiles(context, sSnapshot.data),
                        );
                      },
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      _openAddCourseDialog(context);
                    },
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.grey[600]),
                    child: const Text('Add Course'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _openUploadDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) => FileUploadDialog(),
    );
  }

  List<Widget> _buildCourseTiles(BuildContext context, List<Course>? courses) {
    if (courses == null) {
      return [];
    }

    return courses
        .map(
          (c) => ListTile(
            onTap: () {
              _openEditCourseDialog(context, c);
            },
            title: Text(c.name),
            leading: Icon(
              Icons.circle,
              color: c.defaultAssignmentColor.color,
            ),
          ),
        )
        .toList();
  }

  void _openAddCourseDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) => AddCourseDialog(),
    );
  }

  void _openEditCourseDialog(BuildContext context, Course course) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) => EditCourseDialog(
        initialCourse: course,
      ),
    );
  }
}
