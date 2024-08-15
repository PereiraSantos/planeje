import 'package:flutter/material.dart';
import 'package:planeje/annotation/utils/filter_notifier.dart';
import 'package:planeje/category/entities/category.dart';

// ignore: must_be_immutable
class Filter extends StatefulWidget {
  Filter({super.key, required this.categories, required this.filterNotifier});

  List<Category> categories = [];
  FilterNotifier filterNotifier;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  void update() => setState(() {});

  void updateListFilter(int index, Category value) {
    widget.categories[index].select = !value.select;
    update();
    widget.filterNotifier.setFilter(widget.categories);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Wrap(
          spacing: 2.0,
          runSpacing: 2.0,
          direction: Axis.horizontal,
          children: [
            ...widget.categories.map((category) {
              int index = widget.categories.indexOf(category);
              return GestureDetector(
                onTap: () {
                  updateListFilter(index, category);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: const Color.fromARGB(255, 202, 202, 202)),
                    borderRadius: BorderRadius.circular(5),
                    color: category.select ? Colors.grey : Colors.white,
                  ),
                  child: Text(
                    '${category.description}',
                    style: TextStyle(color: category.select ? Colors.white : Colors.grey, fontSize: 14),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
