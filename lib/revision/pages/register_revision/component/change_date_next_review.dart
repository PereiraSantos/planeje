import 'package:flutter/material.dart';

import '../../../../usercase/format_date.dart';
import '../../../entities/revision.dart';
import '../controller/revision_controller.dart';
import 'check_box.dart';
import 'date_review.dart';

class ChangeDateNextReview extends StatefulWidget {
  const ChangeDateNextReview({
    super.key,
    required this.onClick,
    required this.onClickCalendar,
    this.revisionEntity,
  });

  final Revision? revisionEntity;
  final Function(bool) onClick;
  final Function(String) onClickCalendar;

  @override
  State<ChangeDateNextReview> createState() => _ChangeDateNextReviewState();
}

class _ChangeDateNextReviewState extends State<ChangeDateNextReview> {
  String dateNextRevision = '';
  bool status = false;
  bool showStatus = true;

  void generateNextRevision() {
    if (status) {
      dateNextRevision =
          RevisionRegisterController().nextRevision(widget.revisionEntity?.nextDate ?? dateNextRevision);
    } else {
      dateNextRevision = widget.revisionEntity?.nextDate ?? FormatDate().formatDate(FormatDate().newDate());
    }
  }

  String review() =>
      status && widget.revisionEntity?.nextDate != null && widget.revisionEntity?.nextDate != ""
          ? 'em ${widget.revisionEntity!.nextDate!}'
          : '';

  void setDate(DateTime picked) {
    dateNextRevision = FormatDate().formatDate(picked);
    widget.onClickCalendar(dateNextRevision);
  }

  @override
  void initState() {
    super.initState();
    generateNextRevision();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateReview(
          dateNextRevision: dateNextRevision,
          onClickCalendar: (picked) {
            if (picked.isBefore(DateTime.now())) {
              showStatus = false;
              status = false;
              widget.onClick(status);
              setDate(DateTime.now());
            } else {
              showStatus = true;
              setDate(picked);
            }
            setState(() {});
          },
        ),
        Visibility(
          visible: widget.revisionEntity != null && showStatus ? true : false,
          child: CheckBoxComponent(
            label: 'Revisado ${review()}',
            onClick: (value) {
              status = value;
              widget.onClick(value);
              generateNextRevision();
              widget.onClickCalendar(dateNextRevision);
              setState(() {});
            },
            isChecked: status,
          ),
        ),
      ],
    );
  }
}
