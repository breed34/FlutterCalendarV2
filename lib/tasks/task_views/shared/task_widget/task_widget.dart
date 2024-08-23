import 'package:calendar_v2/server/models/task.dart';
import 'package:calendar_v2/tasks/task_views/shared/task_widget/task_widget_presenter.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  final double? scale;

  const TaskWidget(this.task, {this.scale, super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  final TaskWidgetPresenter _presenter = TaskWidgetPresenter();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _presenter.getCalendarDefaultColor(widget.task),
      builder: (context, snapshot) => Container(
        constraints: BoxConstraints.expand(height: _scaled(16.0)),
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: _getTaskColor(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.task.name,
                style: TextStyle(
                  fontSize: _scaled(10.0),
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(
              size: _scaled(8.0),
              Icons.circle,
              color: snapshot.data?.color,
              shadows: const [
                Shadow(
                  color: Colors.white,
                  blurRadius: 2.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _scaled(double defaultValue) {
    return defaultValue * (widget.scale ?? 1);
  }

  Color _getTaskColor() {
    return widget.task.isComplete
        ? Colors.grey[700]!
        : widget.task.color.color!;
  }
}
