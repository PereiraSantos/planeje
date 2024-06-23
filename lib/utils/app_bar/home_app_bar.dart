import 'package:flutter/material.dart';

import 'package:planeje/widgets/app_bar_widget/notification_app_bar_widget.dart';

class HomeAppBar {
  HomeAppBar({this.quantity});

  Widget buildNotification(BuildContext context) {
    return NotificationAppBarWidget(quantity: quantity ?? 0);
  }

  int? quantity;
}
