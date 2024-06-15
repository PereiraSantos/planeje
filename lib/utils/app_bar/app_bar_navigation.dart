import 'package:flutter/material.dart';

abstract class IAppBarNavigator {
  void navigator(BuildContext context);
  Widget build(BuildContext context);
}

abstract class IAppBarNavigatorAdd {
  Future<void> navigatorAdd(BuildContext context);
  Widget buildAdd(BuildContext context);
  Color? color;
}

abstract class IAppBarNavigatorNotification {
  Widget buildNotification(BuildContext context);
  int? quantity;
  Color? color;
}

abstract class IAppBarSearch {
  Widget buildIcon(BuildContext context);
}
