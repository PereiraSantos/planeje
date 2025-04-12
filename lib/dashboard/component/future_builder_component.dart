import 'package:flutter/material.dart';

class FutureBuilderComponent<T> extends StatelessWidget {
  const FutureBuilderComponent({super.key, required this.future, required this.children});

  final Future<List<T>?> future;
  final Widget Function(List<T>) children;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<T>?> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [children(snapshot.data ?? [])],
            );
          }

          return const SizedBox();
        }

        return const Center(child: CircularProgressIndicator(strokeWidth: 1));
      },
    );
  }
}
