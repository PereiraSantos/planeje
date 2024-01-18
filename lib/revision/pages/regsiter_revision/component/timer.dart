import 'package:flutter/material.dart';

import '../controller/revision_controller.dart';

// ignore: must_be_immutable
class Timer extends StatefulWidget {
  Timer({super.key, required this.controller});

  RevisionRegisterController controller;

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  TimeOfDay? time;

  String getTime() {
    if (time != null) {
      return '${time!.hour} : ${time!.minute}';
    } else {
      var result = DateTime.now();
      return '${result.hour} : ${result.minute}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              getTime(),
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                // widget.controller.setTime(selectedTime!);
                time = selectedTime;
                setState(() {});
              },
              icon: const Icon(
                Icons.access_alarms,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
