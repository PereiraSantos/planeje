import 'package:flutter/material.dart';
import 'package:planeje/utils/format_date.dart';

import '../../../../usercase/time_mask.dart';
import '../../../../widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class TimeRevision extends StatelessWidget {
  TimeRevision({
    super.key,
    required this.onClickTime,
    required this.timeRevision,
    required this.label,
  }) {
    date.text = timeRevision == null || timeRevision == ''
        ? FormatDate.formatTimeString(FormatDate.formatTimeByString(DateTime.now()))
        : timeRevision!;
  }

  final Function(String time) onClickTime;
  String? timeRevision;
  final TextEditingController date = TextEditingController();
  final String label;

  TimeOfDay initDate(String? date) {
    var time = DateTime.now();

    // if (date != null && date != "") time = FormatDate().timeParse(date);
    return TimeOfDay(hour: time.hour, minute: time.minute);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: date,
      inputFormatter: [TimeMask()],
      keyboardType: TextInputType.datetime,
      hintText: label,
      valid: false,
      suffixIcon: IconButton(
        icon: const Icon(
          Icons.timer_outlined,
        ),
        color: Colors.black54,
        iconSize: 22,
        onPressed: () async {
          final TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: initDate(date.text),
          );

          if (time != null) {
            onClickTime('${time.hour}:${time.minute}');
          }
        },
      ),
    );
  }
}
