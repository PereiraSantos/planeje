import 'package:flutter/material.dart';
import 'package:planeje/dashboard/pages/home.dart';
import 'package:planeje/utils/app_bar/app_bar_navigation.dart';
import 'package:planeje/utils/transitions_builder.dart';

import 'package:planeje/widgets/app_bar_widget/home_app_bar_widget.dart';
import 'package:planeje/widgets/app_bar_widget/notification_app_bar_widget.dart';

class HomeAppBar implements IAppBarNavigator, IAppBarNavigatorNotification {
  HomeAppBar({this.quantity, this.color});

  @override
  void navigator(BuildContext context) {
    Navigator.of(context).push(TransitionsBuilder.createRoute(const Home()));
  }

  @override
  Widget build(BuildContext context) {
    return HomeAppBarWidget(onClick: () => navigator(context), color: color);
  }

  @override
  Widget buildNotification(BuildContext context) {
    return NotificationAppBarWidget(quantity: quantity ?? 0);
  }

  @override
  Color? color;

  @override
  int? quantity;
}
