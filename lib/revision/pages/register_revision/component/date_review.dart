import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DateReview extends StatelessWidget {
  const DateReview({
    super.key,
    required this.date,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Revisa em: ', style: TextStyle(color: Colors.black45, fontSize: 16)),
          Text(date, style: const TextStyle(color: Colors.black45, fontSize: 16))
        ],
      ),
    );
  }
}
