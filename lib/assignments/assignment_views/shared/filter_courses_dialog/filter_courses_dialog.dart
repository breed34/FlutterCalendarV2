import 'package:calendar_v2/assignments/assignment_views/shared/filter_courses_dialog/filter_courses_dialog_presenter.dart';
import 'package:calendar_v2/assignments/shared/base_dialog.dart';
import 'package:flutter/material.dart';

class FilterCoursesDialog extends StatefulWidget {
  const FilterCoursesDialog({super.key});

  @override
  State<FilterCoursesDialog> createState() => _FilterCoursesDialogState();
}

class _FilterCoursesDialogState extends State<FilterCoursesDialog> {
  final FilterCoursesDialogPresenter _presenter =
      FilterCoursesDialogPresenter();

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Filter Courses',
      content: StreamBuilder(
        stream: _presenter.getFilterCourses(),
        builder: (context, sSnapshot) => Column(
          children: _buildListChildren(sSnapshot.data),
        ),
      ),
    );
  }

  List<Widget> _buildListChildren(List<FilterCourse>? fCourses) {
    if (fCourses == null) {
      return [];
    }

    return fCourses
        .map((c) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: 160.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(c.course.name),
                    Checkbox(
                      activeColor: c.course.defaultAssignmentColor.color,
                      value: c.show,
                      onChanged: (value) {
                        c.show = value!;
                        _presenter.hideShowCourse(c);
                      },
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }
}
