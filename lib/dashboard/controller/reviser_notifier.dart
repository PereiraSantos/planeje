import 'package:flutter/material.dart';

import '../../revision/entities/revision.dart';

class ReviserNotifier with ChangeNotifier {
  int _quantityReviserCompleted = 0;
  int _quantityReviserDelayed = 0;

  Revision _revision = Revision();

  int get quantityReviserCompleted => _quantityReviserCompleted;
  int get quantityReviserDelayed => _quantityReviserDelayed;

  Revision get revision => _revision;

  void updateQuantityCompleted(int value) {
    _quantityReviserCompleted = value;
    notifyListeners();
  }

  void updateDelayed(int value) {
    _quantityReviserDelayed = value;
    notifyListeners();
  }

  void updateRevision(Revision revission) {
    _revision = revission;
    notifyListeners();
  }
}
