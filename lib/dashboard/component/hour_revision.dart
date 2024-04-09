import 'package:flutter/material.dart';

class HourReviser extends StatelessWidget {
  const HourReviser({
    super.key,
    required this.month,
    required this.week,
  });

  final double month;
  final double week;
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
              "Horas revisadas",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ),
          Card(
            elevation: 6,
            color: Colors.white,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
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
                    "Mês: $month",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, bottom: 10),
                  child: Text(
                    "Semana: $week",
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
