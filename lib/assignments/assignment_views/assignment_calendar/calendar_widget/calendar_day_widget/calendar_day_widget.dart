import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/assignments/assignment_views/assignment_calendar/calendar_widget/calendar_day_widget/calendar_day_dialog/calendar_day_dialog.dart';
import 'package:calendar_v2/assignments/assignment_views/assignment_calendar/calendar_widget/calendar_day_widget/calendar_day_presenter.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_widget/assignment_widget.dart';
import 'package:flutter/material.dart';

class CalendarDayWidget extends StatefulWidget {
  final DateTime day;
  final bool inCurrentMonth;
  final bool isToday;

  const CalendarDayWidget(
    this.day, {
    required this.inCurrentMonth,
    required this.isToday,
    super.key,
  });

  @override
  State<CalendarDayWidget> createState() => _CalendarDayWidgetState();
}

class _CalendarDayWidgetState extends State<CalendarDayWidget> {
  late final CalendarDayPresenter _presenter;

  @override
  void initState() {
    _presenter = CalendarDayPresenter(widget.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showCalendarDayDialog,
      child: Column(
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.symmetric(vertical: 2),
            alignment: Alignment.center,
            decoration: _getNumberDecoration(),
            child: Text(
              widget.day.day.toString(),
              style: _getNumberTextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.white.withOpacity(0)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.1],
                ),
              ),
              child: StreamBuilder<List<Assignment>>(
                stream: _presenter.getAssignments(),
                builder: (context, snapshot) {
                  return ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    clipBehavior: Clip.hardEdge,
                    children: _getAssignmentWidgets(snapshot.data),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCalendarDayDialog() async {
    await showDialog(
      context: context,
      builder: (context) => CalendarDayDialog(widget.day),
    );
  }

  BoxDecoration _getNumberDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: widget.isToday ? Colors.blue : Colors.transparent,
    );
  }

  TextStyle _getNumberTextStyle() {
    Color color = Colors.grey[800]!;

    if (widget.isToday) {
      color = Colors.white;
    } else if (!widget.inCurrentMonth) {
      color = Colors.grey[400]!;
    }

    return TextStyle(
      fontSize: 12,
      fontWeight: widget.isToday ? FontWeight.bold : FontWeight.normal,
      color: color,
    );
  }

  List<Widget> _getAssignmentWidgets(List<Assignment>? assignments) {
    return (assignments ?? []).map((a) => AssignmentWidget(a)).toList();
  }
}
