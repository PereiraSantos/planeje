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
            padding: const EdgeInsets.only(left: 5, top: 10),
            child: const Text(
              "Revisões",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ),
          Card(
            elevation: 2,
            color: Colors.white,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.0),
              borderSide: BorderSide.none,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 5, bottom: 3, top: 10),
                  width: double.maxFinite,
                  child: Text(
                    "Atrasadas: $quantityDelayed",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, bottom: 10),
                  child: Text(
                    "Próximas: $quantityCompleted",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
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
