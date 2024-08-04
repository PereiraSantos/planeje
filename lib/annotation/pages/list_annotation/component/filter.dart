import 'package:flutter/material.dart';
import 'package:planeje/annotation/utils/filter_notifier.dart';
import 'package:planeje/category/entities/category.dart';

// ignore: must_be_immutable
class Filter extends StatefulWidget {
  Filter({super.key, required this.list, required this.filterNotifier});

  List<Category> list = [];
  FilterNotifier filterNotifier;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  void update() => setState(() {});

  void updateListFilter(int index, Category value) {
    widget.list[index].select = !value.select;
    update();
    widget.filterNotifier.setFilter(widget.list);
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
            ...widget.list.map((e) {
              int index = widget.list.indexOf(e);
              return GestureDetector(
                onTap: () {
                  updateListFilter(index, e);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: const Color.fromARGB(255, 202, 202, 202)),
                    borderRadius: BorderRadius.circular(5),
                    color: e.select ? Colors.grey : Colors.white,
                  ),
                  child: Text(
                    '${e.description}',
                    style: TextStyle(color: e.select ? Colors.white : Colors.grey, fontSize: 14),
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
