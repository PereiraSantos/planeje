import 'package:flutter/material.dart';
import 'package:planeje/revision/entities/date_revision.dart';

import '../../../../utils/format_date.dart';
import '../../../../widgets/text_form_field_widget.dart';
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

  final DateRevision? revisionEntity;
  final Function(bool) onClick;
  final Function(String) onClickCalendar;

  @override
  State<ChangeDateNextReview> createState() => _ChangeDateNextReviewState();
}

class _ChangeDateNextReviewState extends State<ChangeDateNextReview> {
  String dateNextRevision = '';
  bool status = false;
  bool showStatus = true;
  final TextEditingController day = TextEditingController();
  bool show = false;

  void generateNextRevision() {
    if (status) {
      dateNextRevision = RevisionRegisterController()
          .nextRevision(widget.revisionEntity?.dateRevision ?? dateNextRevision, int.parse(day.text));
    } else {
      dateNextRevision = widget.revisionEntity?.nextDate ?? FormatDate.formatDate(FormatDate.newDate());
    }
  }

  String review() =>
      status && widget.revisionEntity?.nextDate != null && widget.revisionEntity?.nextDate != ""
          ? 'em ${widget.revisionEntity!.nextDate!}'
          : '';

  void setDate(DateTime picked) {
    dateNextRevision = FormatDate.formatDate(picked);
    widget.onClickCalendar(dateNextRevision);
  }

  bool validDayIsNull() {
    if (day.text == '') return false;
    return true;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Próxima revisão em",
                      style: TextStyle(color: Colors.black45, fontSize: 17),
                    ),
                    SizedBox(
                      width: 90,
                      height: 40,
                      child: TextFormFieldWidget(
                        controller: day,
                        keyboardType: TextInputType.number,
                        onChange: (value) {
                          show = value != '' && (int.parse(value!) > 999 || value.length > 3) ? true : false;
                          setState(() {});
                        },
                      ),
                    ),
                    const Text(
                      "dias.",
                      style: TextStyle(color: Colors.black45, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: show,
                child: const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Máximo de dias 999.',
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  ),
                ),
              ),
              CheckBoxComponent(
                label: 'Revisado ${review()}',
                onClick: (value) {
                  if (!validDayIsNull()) {
                    day.text = '30';
                    day.selection = TextSelection.fromPosition(TextPosition(offset: day.text.length));
                  }

                  status = value;
                  widget.onClick(value);
                  generateNextRevision();
                  widget.onClickCalendar(dateNextRevision);
                  setState(() {});
                },
                isChecked: status,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
