import 'package:flutter/material.dart';

import '../../../usercase/date_mask.dart';
import '../../../widgets/text_form_field_widget.dart';
import 'check_box.dart';

class NextReview extends StatefulWidget {
  const NextReview({
    super.key,
    required this.controller,
    required this.onClick,
    required this.onClickCalendar,
  });

  final Function(bool value) onClick;
  final Function(DateTime picked) onClickCalendar;
  final TextEditingController controller;

  @override
  State<NextReview> createState() => _NextReviewState();
}

class _NextReviewState extends State<NextReview> {
  bool checkBoxIsChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckBoxComponent(
          isChecked: checkBoxIsChecked,
          onClick: (value) {
            widget.onClick(value);
            checkBoxIsChecked = value;
            setState(() {});
          },
          child: const Text(
            "Revisado",
            style: TextStyle(fontSize: 16),
          ),
        ),
        Visibility(
          visible: checkBoxIsChecked,
          child: TextFormFieldWidget(
            controller: widget.controller,
            inputFormatter: [DateMask()],
            keyboardType: TextInputType.datetime,
            hintText: "Proxima revisão",
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.date_range,
              ),
              color: Colors.black54,
              iconSize: 22,
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2025),
                );

                if (picked != null) {
                  widget.onClickCalendar(picked);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
