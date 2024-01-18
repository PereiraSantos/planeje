import 'package:flutter/material.dart';

import '../../../../model/date_revision_model.dart';

// ignore: must_be_immutable
class DropDownButtonCustom extends StatefulWidget {
  DropDownButtonCustom({
    super.key,
    required this.onClick,
    this.dateRevisionModel,
  });

  final Function(List<DateRevisionModel>) onClick;
  List<DateRevisionModel>? dateRevisionModel;

  @override
  State<DropDownButtonCustom> createState() => _DropDownButtonCustomState();
}

class _DropDownButtonCustomState extends State<DropDownButtonCustom> {
  List<int> list = List<int>.generate(45, (index) => index + 1);

  int? dropdownValue;

  List<Widget> buildListDay() {
    List<Widget> list = [];

    if (widget.dateRevisionModel != null) {
      for (var i = 0; i < widget.dateRevisionModel!.length; i++) {
        if (!widget.dateRevisionModel![i].delete!) {
          list.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('${widget.dateRevisionModel![i].quantityDay}'),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.black45,
                    size: 20,
                  ),
                  onPressed: () {
                    var result = widget.dateRevisionModel!.where((element) => element.delete == false);

                    if (result.length > 1) {
                      setState(() {
                        widget.dateRevisionModel![i].delete = true;
                      });

                      widget.onClick(widget.dateRevisionModel!);
                    }
                  },
                ),
              ],
            ),
          );
        }
      }
    }

    return list;
  }

  @override
  void initState() {
    super.initState();

    widget.onClick(widget.dateRevisionModel ?? []);
  }

  @override
  Widget build(BuildContext context) {
    dropdownValue ??= list.first;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: DropdownButtonFormField<int>(
            validator: (value) {
              if (value == 1 && widget.dateRevisionModel!.isEmpty) {
                return "Selecione um valor";
              }
              return null;
            },
            value: dropdownValue,
            icon: const Icon(Icons.expand_more),
            elevation: 16,
            isExpanded: true,
            isDense: true,
            style: const TextStyle(color: Colors.black54),
            onChanged: (int? value) {
              var result = widget.dateRevisionModel!.where((element) => element.quantityDay == value);

              if (result.isEmpty) {
                widget.dateRevisionModel!.add(DateRevisionModel(quantityDay: value));
              }

              setState(() {
                dropdownValue = value;
              });

              widget.onClick(widget.dateRevisionModel ?? []);
            },
            items: list.map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Card(
            elevation: 5,
            child: Column(
              children: buildListDay(),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(45))
      ],
    );
  }
}
