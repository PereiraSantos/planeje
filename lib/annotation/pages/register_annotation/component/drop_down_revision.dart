import 'package:flutter/material.dart';

import '../../../../revision/entities/revision.dart';
import '../../../../revision/pages/list_revision/controller/revision_controller.dart';

// ignore: must_be_immutable
class DropDownButtonCustom extends StatelessWidget {
  DropDownButtonCustom({
    super.key,
    required this.onClick,
    this.idRevision,
  }) {
    if (idRevision != null) dropdownValue = idRevision;
  }

  final Function(int?) onClick;
  final int? idRevision;
  int? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RevisionListController().getRevision(value: ''),
      builder: (BuildContext context, AsyncSnapshot<List<Revision>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: DropdownButtonFormField<int>(
                hint: const Text("Revisão", style: TextStyle(fontSize: 18, color: Colors.grey)),
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
    );
  }
}
