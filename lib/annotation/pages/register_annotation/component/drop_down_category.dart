import 'package:flutter/material.dart';
import 'package:planeje/category/datasource/database/datasource_category_repository.dart';
import 'package:planeje/category/entities/category.dart';
import 'package:planeje/category/utils/find_category.dart';

// ignore: must_be_immutable
class DropDownButtonCategory extends StatelessWidget {
  DropDownButtonCategory({
    super.key,
    required this.onClick,
    this.idCategory,
  }) {
    if (idCategory != null) dropdownValue = idCategory;
  }

  final Function(int?) onClick;
  final int? idCategory;
  int? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetCategory(CategoryDatabase()).getAll(''),
      builder: (BuildContext context, AsyncSnapshot<List<Category>?> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: DropdownButtonFormField<int>(
                hint: const Text("Categoria", style: TextStyle(fontSize: 17, color: Colors.grey)),
                value: dropdownValue,
                icon: const Icon(Icons.expand_more),
                elevation: 14,
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
