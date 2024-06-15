import 'package:flutter/material.dart';

class SearchAppBarWidget extends StatelessWidget {
  const SearchAppBarWidget({super.key, required this.onClick});

  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: SizedBox(
        width: 30,
        child: IconButton(
          onPressed: () async => await onClick(),
          icon: const Icon(
            Icons.search,
            color: Colors.black54,
            size: 20,
          ),
        ),
      ),
    );
  }
}
