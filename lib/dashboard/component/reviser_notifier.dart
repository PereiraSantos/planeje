import 'package:flutter/material.dart';

import '../../revision/entities/revision.dart';

class ReviserNotifier with ChangeNotifier {
  int _quantityCompleted = 0;
  int _quantityDelayed = 0;
  double _quantityHourMonth = 0;
  double _quantityHourWeek = 0;
  Revision _revision = Revision();

  int get quantityCompleted => _quantityCompleted;
  int get quantityDelayed => _quantityDelayed;

  double get quantityHourMonth => _quantityHourMonth;
  double get quantityHourWeek => _quantityHourWeek;

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

  void updateQuantityHourMonth(double value) {
    _quantityHourMonth = value;
    notifyListeners();
  }

  void updateQuantityHourWeek(double value) {
    _quantityHourWeek = value;
    notifyListeners();
  }
}
