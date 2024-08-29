import 'package:calendar_v2/server/models/assignment.dart';
import 'package:calendar_v2/assignments/assignment_views/shared/assignment_widget/assignment_widget_presenter.dart';
import 'package:calendar_v2/server/models/enums.dart';
import 'package:flutter/material.dart';

class AssignmentWidget extends StatefulWidget {
  final Assignment assignment;
  final double? scale;

  const AssignmentWidget(this.assignment, {this.scale, super.key});

  @override
  State<AssignmentWidget> createState() => _AssignmentWidgetState();
}

class _AssignmentWidgetState extends State<AssignmentWidget> {
  final AssignmentWidgetPresenter _presenter = AssignmentWidgetPresenter();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AssignmentColor>(
      stream: _presenter.getCourseDefaultColor(widget.assignment),
      builder: (context, sSnapshot) => Container(
        constraints: BoxConstraints.expand(height: _scaled(16.0)),
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: _getAssignmentColor(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.assignment.name,
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
              color: sSnapshot.data?.color,
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

  Color _getAssignmentColor() {
    return widget.assignment.isComplete
        ? Colors.grey[700]!
        : widget.assignment.color.color!;
  }
}
