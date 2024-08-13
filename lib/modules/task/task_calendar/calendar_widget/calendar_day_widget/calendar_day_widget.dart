import 'package:calendar_v2/modules/task/task_calendar/calendar_widget/calendar_day_widget/calendar_day_dialog/calendar_day_dialog.dart';
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
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.hardEdge,
                children: _getTaskWidgets(),
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

  List<Widget> _getTaskWidgets() {
    return _presenter.getTasks().map((t) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: t.color.color,
        ),
        child: Text(
          t.name,
          style: const TextStyle(
            fontSize: 10,
            overflow: TextOverflow.ellipsis,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }).toList();
  }
}
