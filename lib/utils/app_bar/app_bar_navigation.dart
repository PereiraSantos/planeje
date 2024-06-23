import 'package:flutter/material.dart';

abstract class IAppBarNavigatorAdd {
  Future<void> navigatorAdd(BuildContext context);
  Widget buildAdd(BuildContext context);
}
