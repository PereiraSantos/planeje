import 'package:flutter/material.dart';

class ReviserLate extends StatelessWidget {
  const ReviserLate({
    super.key,
    required this.quantityCompleted,
    required this.quantityDelayed,
  });

  final int quantityCompleted;
  final int quantityDelayed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: const Text(
              "Revisões",
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 5, bottom: 1, top: 3),
                  width: double.maxFinite,
                  child: Text(
                    "Atrasadas: $quantityDelayed",
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, bottom: 3),
                  child: Text(
                    "Revisadas: $quantityCompleted",
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
