import 'package:calendar_v2/assignments/assignment_views/shared/assignment_scaffold/assignment_scaffold_presenter.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/filter_courses_dialog/filter_courses_dialog.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_scaffold/nav_drawer_widget/nav_drawer_widget.dart';
import 'package:flutter/material.dart';

class AssignmentScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;

  const AssignmentScaffold({
    required this.title,
    required this.body,
    this.actions,
    super.key,
  });

  @override
  State<AssignmentScaffold> createState() => _AssignmentScaffoldState();
}

class _AssignmentScaffoldState extends State<AssignmentScaffold> {
  final AssignmentScaffoldPresenter _presenter = AssignmentScaffoldPresenter();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<void> _ensureCoursesLoaded;

  @override
  void initState() {
    _ensureCoursesLoaded = _presenter.ensureCoursesLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
        actions: [
          ...(widget.actions ?? []),
          const SizedBox(width: 8.0),
          IconButton(
            onPressed: () {
              _openFilterCoursesDialog(context);
            },
            icon: const Icon(Icons.filter_alt_outlined),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(Icons.more_vert),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: FutureBuilder(
        future: _ensureCoursesLoaded,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return widget.body;
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      endDrawer: const NavDrawerWidget(),
    );
  }

  void _openFilterCoursesDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext buildContext) => const FilterCoursesDialog(),
    );
  }
}
