import 'package:calendar_v2/modules/task/task_calendar/calendar_widget/calendar_widget.dart';
import 'package:calendar_v2/modules/task/task_calendar/task_calendar_presenter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class TaskCalendarView extends StatefulWidget {
  TaskCalendarView({super.key});

  @override
  State<TaskCalendarView> createState() => _TaskCalendarViewState();
}

class _TaskCalendarViewState extends State<TaskCalendarView> {
  final Duration _pageChangeDuration = const Duration(milliseconds: 300);
  final Curve _pageChangeCurve = Curves.easeInOutCubic;
  final TaskCalendarPresenter _presenter = TaskCalendarPresenter();
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _presenter.initialPageIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calendar")),
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

  void _updateCurrentPageIndex(int value) {
    setState(() {
      _presenter.setCurrentPageIndex(value);
    });
  }

  CalendarWidget? _calendarPageBuilder(BuildContext context, int index) {
    var monthFirstDay = _presenter.getCurrentMonthFirstDay();
    return CalendarWidget(monthFirstDay: monthFirstDay);
  }
}
