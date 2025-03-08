import 'package:flutter/material.dart';
import 'package:planeje/widgets/text_form_field_widget.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.setValue});

  final Function(String?) setValue;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController search = TextEditingController();
  bool _showInput = false;

  void _change(bool value) {
    setState(() {
      _showInput = value;
      widget.setValue('');
      search.clear();
    });
  }

  void _setValue(String? value) => setState(() => widget.setValue(value));

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _showInput,
      replacement: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () => _change(true),
          child: Icon(Icons.search, size: 22, color: Colors.black54),
        ),
      ),
      child: SizedBox(
        width: 250,
        height: 20,
        child: TextFormFieldWidget(
          controller: search,
          borderRadius: 20,
          autofocus: false,
          fontSize: 16,
          contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          suffixIcon: GestureDetector(
            onTap: () => _change(false),
            child: Icon(Icons.close, size: 20, color: Colors.black54),
          ),
          onChange: (value) => _setValue(value),
        ),
      ),
    );
  }
}
