import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:planeje/widgets/app_bar_widget/notification_app_bar_widget.dart';
import 'package:planeje/widgets/app_bar_widget/setting_app_bar_widget.dart';

class HomeAppBar {
  HomeAppBar({this.quantity});

  int? quantity;

  Widget buildNotification() {
    return NotificationAppBarWidget(quantity: quantity ?? 0);
  }

  Widget buildSetting({required Function() onClick}) {
    return SettingAppBarWidget(onClick: onClick);
  }
}
