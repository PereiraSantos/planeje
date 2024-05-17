import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    super.key,
    required this.controller,
    this.onChange,
    this.inputFormatter,
    this.maxLine = 1,
    this.minLine = 1,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.borderRadius,
    this.valid = true,
    this.suffixIcon,
    this.textArea = false,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String? hintText;
  List<TextInputFormatter>? inputFormatter = [];
  final int maxLine;
  final int minLine;
  final TextInputType keyboardType;
  final double? borderRadius;
  final bool valid;
  final Widget? suffixIcon;
  final bool textArea;
  final bool readOnly;
  final Function(String?)? onChange;

  InputBorder theme(double value) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(value),
      borderSide: const BorderSide(
        color: Colors.black54,
        width: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20, bottom: 10),
      child: TextFormField(
          controller: controller,
          maxLines: maxLine,
          minLines: minLine,
          readOnly: readOnly,
          autofocus: false,
          keyboardType: keyboardType,
          inputFormatters: inputFormatter,
          enableInteractiveSelection: false,
          textCapitalization: TextCapitalization.sentences,
          style: const TextStyle(fontSize: 22, color: Colors.black54),
          decoration: InputDecoration(
            labelText: hintText,
            labelStyle: const TextStyle(
              color: Colors.black54,
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
            ),
            suffixIcon: suffixIcon,
            hintStyle: const TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontFamily: 'helvetica_neue_light',
            ),
            border: borderRadius != null ? theme(borderRadius!) : null,
          ),
          validator: (value) {
            if (valid) {
              return validator(value);
            }
            return null;
          },
          onChanged: (value) {
            if (onChange != null) onChange!(value);
          }),
    );
  }

  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório!!!';
    }
    return null;
  }
}
