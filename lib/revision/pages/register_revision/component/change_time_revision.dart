import 'package:flutter/material.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/pages/register_revision/component/time_revision.dart';

class ChangeTimeRevision extends StatefulWidget {
  const ChangeTimeRevision(
      {super.key, required this.onClickTimeInit, required this.onClickTimeEnd, this.revisionEntity});

  final Function(String time) onClickTimeInit;
  final Function(String time) onClickTimeEnd;
  final DateRevision? revisionEntity;

  @override
  State<ChangeTimeRevision> createState() => _ChangeTimeRevisionState();
}

class _ChangeTimeRevisionState extends State<ChangeTimeRevision> {
  String? timeInit;
  String? timeEnd;

  void initTime() {
    if (widget.revisionEntity != null) {
      timeInit = widget.revisionEntity!.hourInit;
      timeEnd = widget.revisionEntity!.hourEnd;
    }
  }

  @override
  void initState() {
    super.initState();
    initTime();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 1,
          child: TimeRevision(
            label: 'Das',
            onClickTime: (time) {
              timeInit = time;
              widget.onClickTimeInit(time);
              setState(() {});
            },
            timeRevision: timeInit,
          ),
        ),
        Expanded(
          flex: 1,
          child: TimeRevision(
            label: 'Até',
            onClickTime: (time) {
              timeEnd = time;
              widget.onClickTimeEnd(time);
              setState(() {});
            },
            timeRevision: timeEnd,
          ),
        ),
      ],
    );
  }
}
