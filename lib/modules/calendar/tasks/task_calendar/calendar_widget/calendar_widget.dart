import 'package:calendar_v2/modules/calendar/tasks/task_calendar/calendar_widget/calendar_day_widget/calendar_day_widget.dart';
import 'package:calendar_v2/modules/calendar/tasks/task_calendar/calendar_widget/calendar_widget_presenter.dart';
import 'package:flutter/material.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime monthFirstDay;

  const CalendarWidget({required this.monthFirstDay, super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late final CalendarWidgetPresenter _presenter;

  @override
  void initState() {
    _presenter = CalendarWidgetPresenter(monthFirstDay: widget.monthFirstDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: _buildDayHeaders()),
        ..._buildDayCells(),
      ],
    );
  }

  List<Widget> _buildDayHeaders() {
    var weekdays = _presenter.getAbbreviatedDays();
    var dayHeaders = weekdays.map((weekday) {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: _getTableBorder(weekdays, weekday),
          ),
          child: Text(
            weekday,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();

    return dayHeaders;
  }

  List<Widget> _buildDayCells() {
    return _presenter.getCellDays().map((week) {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: week.map((day) {
            return Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  border: _getTableBorder(week, day),
                ),
                child: CalendarDayWidget(
                  day,
                  isToday: _presenter.isToday(day),
                  inCurrentMonth: _presenter.isInCurrentMonth(day),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }).toList();
  }

  Border _getTableBorder(List list, Object item) {
    BorderSide leftBorder = BorderSide(color: Colors.grey[400]!);

    if (item == list.first) {
      leftBorder = BorderSide.none;
    }

    return Border(
      left: leftBorder,
      top: BorderSide(color: Colors.grey[400]!),
    );
  }
}
