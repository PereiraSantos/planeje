import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({super.key, required this.label, required this.onClick});

  final String label;
  final Function onClick;

  factory TextButtonWidget.cancel(Function onClick) => TextButtonWidget(label: 'CANCELA', onClick: onClick);
  factory TextButtonWidget.save(Function onClick) => TextButtonWidget(label: 'SALVAR', onClick: onClick);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
      child: TextButton(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 12.0, fontFamily: 'helvetica_neue_light', color: Colors.black54),
          ),
        ),
        onPressed: () => onClick(),
      ),
    );
  }
}
