import 'package:flutter/material.dart';
import 'package:planeje/settings/entities/settings.dart';

class FutureBuilderCustom {
  Widget future({required Future<Settings?> future, required Widget Function(Settings?) child}) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<Settings?> snapshot) {
        if (snapshot.hasData) return child(snapshot.data);

        return const Center(
          child: CircularProgressIndicator(strokeWidth: 1),
        );
      },
    );
  }
}
