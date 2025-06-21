import 'package:flutter/material.dart';

class FutureBuilderComponent<T> extends StatelessWidget {
  const FutureBuilderComponent({super.key, required this.future, required this.children, this.message});

  final Future<List<T>?> future;
  final Widget Function(List<T>) children;
  final String? message;

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

          return SizedBox(
            child: Visibility(
              visible: message != null,
              child: Center(
                child: Text(
                  '$message',
                  style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator(strokeWidth: 1));
      },
    );
  }
}
