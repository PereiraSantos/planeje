import 'package:flutter/material.dart';
import 'package:planeje/revision/entities/date_revision.dart';

import '../../../../utils/format_date.dart';
import '../../../../widgets/text_form_field_widget.dart';

import 'date_review.dart';

class ChangeDateNextReview extends StatefulWidget {
  const ChangeDateNextReview({
    super.key,
    required this.onClickCalendar,
    this.revisionEntity,
    required this.onDay,
  });

  final DateRevision? revisionEntity;
  final Function(String) onClickCalendar;
  final Function(int) onDay;

  @override
  State<ChangeDateNextReview> createState() => _ChangeDateNextReviewState();
}

class _ChangeDateNextReviewState extends State<ChangeDateNextReview> {
  String dateNextRevision = '';
  final TextEditingController day = TextEditingController(text: '0');
  bool show = false;
  bool showRevisionDate = false;

  void generateNextRevision({int? value, bool? edit = false}) {
    var dateTemp = FormatDate.formatDate(FormatDate.newDate());

    if (widget.revisionEntity?.nextDate != null) dateTemp = widget.revisionEntity!.nextDate!;
    if (dateNextRevision != '') dateTemp = dateNextRevision;
    if (edit!) {
      dateTemp = widget.revisionEntity!.nextDate ?? FormatDate.formatDate(FormatDate.newDate());
    }

    dateNextRevision = nextRevision(dateTemp, value ?? int.parse(day.text));

    widget.onClickCalendar(dateNextRevision);
  }

  String nextRevision(String date, int day) {
    DateTime dateTemp;

    if (date == '') date = FormatDate.formatDate(DateTime.now());

    dateTemp = FormatDate.dateParse(date);
    dateTemp = dateTemp.add(Duration(days: day));

    return FormatDate.formatDate(dateTemp);
  }

  void setDate(DateTime picked) {
    dateNextRevision = FormatDate.formatDate(picked);
    widget.onClickCalendar(dateNextRevision);
  }

  @override
  void initState() {
    super.initState();
    if (widget.revisionEntity?.day != null) {
      day.text = (widget.revisionEntity!.day).toString();
      dateNextRevision = (widget.revisionEntity!.nextDate).toString();
      showRevisionDate = true;
      widget.onClickCalendar(dateNextRevision);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 25, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Lembrar data próxima revisão em",
                    style: TextStyle(color: Colors.black45, fontSize: 16),
                  ),
                  SizedBox(
                    width: 65,
                    height: 40,
                    child: TextFormFieldWidget(
                      controller: day,
                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        day.text = value.toString().trim().replaceAll(RegExp(r'[.,-]'), '');

                        show = false;

                        showRevisionDate = day.text == '0' || day.text == '' ? false : true;

                        if ((day.text != '' && (int.parse(day.text) > 100)) || day.text.length > 2) {
                          show = true;
                          day.text = day.text.substring(0, day.text.length - 1);
                        }

                        if (!show) generateNextRevision(value: day.text != '' ? null : 0, edit: true);

                        if (day.text != '') widget.onDay(int.parse(day.text));

                        setState(() {});
                      },
                      valid: false,
                    ),
                  ),
                  const Text("dias.", style: TextStyle(color: Colors.black45, fontSize: 16)),
                ],
              ),
            ),
            Visibility(
              visible: show,
              child: const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Permitido de 0 a 100 dias.',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: showRevisionDate,
          child: DateReview(date: dateNextRevision),
        ),
      ],
    );
  }
}
