import 'package:calendar_v2/models/task.dart';
import 'package:calendar_v2/modules/task/task_calendar/calendar_widget/calendar_day_widget/calendar_day_presenter.dart';
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
  late final CalendarDayWidgetPresenter _presenter;
  late final List<Task> _tasks;

  @override
  void initState() {
    _presenter = CalendarDayWidgetPresenter(widget.day);
    //_tasks = _presenter.getTasks();
    _tasks = [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }

  BoxDecoration _getNumberDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: widget.isToday ? Colors.blue : Colors.transparent,
    );
  }

  TextStyle _getNumberTextStyle() {
    Color color = Colors.black.withOpacity(0.9);

    if (widget.isToday) {
      color = Colors.white;
    } else if (!widget.inCurrentMonth) {
      color = Colors.black.withOpacity(0.3);
    }

    return TextStyle(
      fontSize: 12,
      fontWeight: widget.isToday ? FontWeight.bold : FontWeight.normal,
      color: color,
    );
  }
}
