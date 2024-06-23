import 'package:flutter/material.dart';
import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/learn/utils/find_learn.dart';

// ignore: must_be_immutable
class DropDownButtonCustomRevision extends StatelessWidget {
  DropDownButtonCustomRevision({
    super.key,
    required this.onClick,
    this.idLearn,
  }) {
    if (idLearn != null) dropdownValue = idLearn;
  }

  final Function(int?) onClick;
  final int? idLearn;
  int? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: FutureBuilder(
        future: GetLearn(LearnDatabase()).getAllLearn(''),
        builder: (BuildContext context, AsyncSnapshot<List<Learn>?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: DropdownButtonFormField<int>(
                  hint: const Text("Conhecimento", style: TextStyle(fontSize: 18, color: Colors.grey)),
                  value: dropdownValue,
                  icon: const Icon(Icons.expand_more),
                  elevation: 16,
                  isExpanded: true,
                  isDense: true,
                  style: const TextStyle(color: Colors.black54),
                  onChanged: (int? value) => onClick(value),
                  items: snapshot.data!.map<DropdownMenuItem<int>>((value) {
                    return DropdownMenuItem<int>(
                      value: value.id,
                      child: Text('${value.description}'),
                    );
                  }).toList(),
                ),
              );
            }
            return const SizedBox();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
