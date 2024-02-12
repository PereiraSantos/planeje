import 'package:flutter/material.dart';

import '../../../../usercase/date_mask.dart';
import '../../../../usercase/format_date.dart';
import '../../../../widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class DateReview extends StatelessWidget {
  DateReview({
    super.key,
    required this.onClickCalendar,
    required dateNextRevision,
  }) {
    date.text = dateNextRevision;
  }

  final Function(DateTime picked) onClickCalendar;
  String? dateNextRevision;
  final TextEditingController date = TextEditingController();

  DateTime initDate(String? date) => date != null ? FormatDate().dateParse(date) : DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: date,
      inputFormatter: [DateMask()],
      keyboardType: TextInputType.datetime,
      hintText: "Revisa em",
      valid: false,
      suffixIcon: IconButton(
        icon: const Icon(
          Icons.date_range,
        ),
        color: Colors.black54,
        iconSize: 22,
        onPressed: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: initDate(date.text),
            firstDate: DateTime(2021),
            lastDate: DateTime(2025),
          );

          if (picked != null) {
            onClickCalendar(picked);
          }
        },
      ),
    );
  }
}