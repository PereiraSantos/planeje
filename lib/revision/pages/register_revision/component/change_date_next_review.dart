import 'package:flutter/material.dart';
import 'package:planeje/revision/entities/date_revision.dart';

import '../../../../utils/format_date.dart';
import '../../../../widgets/text_form_field_widget.dart';

import 'check_box.dart';
import 'date_review.dart';

class ChangeDateNextReview extends StatefulWidget {
  const ChangeDateNextReview({
    super.key,
    required this.onClickCalendar,
    this.revisionEntity,
  });

  final DateRevision? revisionEntity;
  final Function(String) onClickCalendar;

  @override
  State<ChangeDateNextReview> createState() => _ChangeDateNextReviewState();
}

class _ChangeDateNextReviewState extends State<ChangeDateNextReview> {
  String dateNextRevision = '';
  bool status = false;
  final TextEditingController day = TextEditingController(text: '30');
  bool show = false;
  List<String> dates = [];
  bool digitated = false;

  void generateNextRevision({int? value, bool? edit = false}) {
    var dateTemp = FormatDate.formatDate(FormatDate.newDate());

    if (widget.revisionEntity?.nextDate != null) dateTemp = widget.revisionEntity!.nextDate!;
    if (status && dateNextRevision != '') dateTemp = dateNextRevision;
    if (edit!) {
      dateTemp = widget.revisionEntity!.nextDate ?? FormatDate.formatDate(FormatDate.newDate());
    }

    dateNextRevision = nextRevision(dateTemp, value ?? int.parse(day.text));

    dates.add(dateNextRevision);
  }

  void lastDate() {
    if (!status) {
      dates.removeLast();
      dateNextRevision = dates.last;
    }
  }

  String nextRevision(String date, int day) {
    DateTime dateTemp;

    if (date == '') date = FormatDate.formatDate(DateTime.now());

    dateTemp = FormatDate.dateParse(date);
    dateTemp = dateTemp.add(Duration(days: day));

    return FormatDate.formatDate(dateTemp);
  }

  String review() {
    try {
      if (status && widget.revisionEntity?.nextDate != null && widget.revisionEntity?.nextDate != "") {
        return 'em ${dates[dates.length - 2]}';
      }
    } catch (e) {
      return '';
    }
    return '';
  }

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
            if (picked.isBefore(DateTime.now())) status = false;

            setDate(picked);
            setState(() {});
          },
        ),
        Column(
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

                        generateNextRevision(value: value != '' ? null : 0, edit: true);
                        setState(() {});
                      },
                      valid: false,
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
                  day.selection = TextSelection.fromPosition(TextPosition(offset: day.text.length));
                }

                status = value;
                lastDate();
                if (status) generateNextRevision(value: day.text != '' ? null : 0);
                widget.onClickCalendar(dateNextRevision);
                setState(() {});
              },
              isChecked: status,
            ),
          ],
        ),
      ],
    );
  }
}
