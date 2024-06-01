import 'package:flutter/material.dart';

import '../../revision/entities/revision.dart';

class ReviserNotifier with ChangeNotifier {
  int _quantityCompleted = 0;
  int _quantityDelayed = 0;

  Revision _revision = Revision();

  int get quantityCompleted => _quantityCompleted;
  int get quantityDelayed => _quantityDelayed;

  Revision get revision => _revision;

  void updateQuantityCompleted(int value) {
    _quantityCompleted = value;
    notifyListeners();
  }

  void updateDelayed(int value) {
    _quantityDelayed = value;
    notifyListeners();
  }

  void updateRevision(Revision revission) {
    _revision = revission;
    notifyListeners();
  }
}
