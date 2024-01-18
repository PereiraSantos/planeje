import 'package:flutter/material.dart';

import '../../register_revision/controller/revision_controller.dart';

// ignore: must_be_immutable
class TextFieldSearch extends StatelessWidget {
  const TextFieldSearch({
    Key? key,
    required this.onFieldSubmit,
    required this.controller,
  }) : super(key: key);

  final Function(String?) onFieldSubmit;
  final RevisionController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, top: 10, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
            child: Material(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                controller: controller.textController,
                maxLines: 1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Procurar...',
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      borderSide: BorderSide.none),
                ),
                style: const TextStyle(fontSize: 20),
                onFieldSubmitted: onFieldSubmit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
