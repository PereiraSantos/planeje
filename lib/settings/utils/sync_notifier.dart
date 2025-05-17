import 'package:flutter/material.dart';
import 'package:planeje/settings/component/status_component.dart';

enum Status {
  start(widget: Start()),
  loading(widget: Loading()),
  concluded(widget: Concluded()),
  erro(widget: Erro());

  const Status({required this.widget});

  final StatusFactory widget;
}

class SyncNotifier with ChangeNotifier {
  StatusFactory status = Status.start.widget;

  void start() {
    status = Status.start.widget;
  }

  void concluded() {
    status = Status.concluded.widget;
    notifyListeners();
  }

  void loading() {
    status = Status.loading.widget;
    notifyListeners();
  }

  void erro() {
    status = Status.erro.widget;
    notifyListeners();
  }
}
