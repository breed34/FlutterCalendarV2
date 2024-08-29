import 'package:calendar_v2/assignments/assignment_views/assignment_calendar/calendar_widget/calendar_widget.dart';
import 'package:calendar_v2/assignments/assignment_views/assignment_calendar/assignment_calendar_presenter.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_scaffold/assignment_scaffold.dart';
import 'package:flutter/material.dart';

class AssignmentCalendarView extends StatefulWidget {
  const AssignmentCalendarView({super.key});

  @override
  State<AssignmentCalendarView> createState() => _AssignmentCalendarViewState();
}

class _AssignmentCalendarViewState extends State<AssignmentCalendarView> {
  final Duration _pageChangeDuration = const Duration(milliseconds: 800);
  final Curve _pageChangeCurve = Curves.easeOutCubic;
  final AssignmentCalendarPresenter _presenter = AssignmentCalendarPresenter();
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _presenter.initialPageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AssignmentScaffold(
      title: 'Calendar',
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/assignments/prioritizer');
          },
          icon: const Icon(Icons.check_box_outlined),
        ),
      ],
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_presenter.getCurrentMonthString()),
                  Row(
                    children: [
                      IconButton(
                        onPressed: _previousPage,
                        icon: const Icon(Icons.chevron_left),
                      ),
                      IconButton(
                        onPressed: _nextPage,
                        icon: const Icon(Icons.chevron_right),
                      ),
                      const SizedBox(width: 12.0),
                      Text(_presenter.getCurrentYearString()),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemBuilder: _calendarPageBuilder,
                onPageChanged: _updateCurrentPageIndex,
                controller: _pageController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: _pageChangeDuration,
      curve: _pageChangeCurve,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: _pageChangeDuration,
      curve: _pageChangeCurve,
    );
  }

  void _updateCurrentPageIndex(int index) {
    setState(() {
      _presenter.setCurrentPageIndex(index);
    });
  }

  CalendarWidget? _calendarPageBuilder(BuildContext context, int index) {
    _presenter.setCurrentPageIndex(index);
    var monthFirstDay = _presenter.getCurrentMonthFirstDay();
    return CalendarWidget(monthFirstDay: monthFirstDay);
  }
}
