import 'package:flutter/material.dart';

class ReviserLate extends StatelessWidget {
  const ReviserLate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Card(
        elevation: 6,
        color: const Color.fromARGB(255, 255, 176, 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5, top: 10),
              child: const Text(
                "Revisão",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: const Text(
                "Revisão atrasadas: 1",
                style: TextStyle(fontSize: 14),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5, bottom: 10),
              child: const Text(
                "Revisão realizadas: 3",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
