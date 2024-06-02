import 'package:flutter/material.dart';

import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/pages/list_revision/page/list_revision.dart';
import 'package:planeje/revision/pages/register_revision/page/register_revision_page.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/utils/app_bar/app_bar_navigation.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/app_bar_widget/add_app_bar_widget.dart';
import 'package:planeje/widgets/app_bar_widget/app_bar_button_widget.dart';
import 'package:planeje/utils/transitions_builder.dart';

class RevisionAppBar implements IAppBarNavigator, IAppBarNavigatorAdd {
  RevisionAppBar({required this.reloadPage, this.color});

  Function() reloadPage;

  @override
  void navigator(BuildContext context) {
    Navigator.of(context).push(TransitionsBuilder.createRoute(const ListRevision()));
  }

  @override
  Widget build(BuildContext context) {
    return AppBarButtonWidget(onClick: () => navigator(context), title: 'Revisão', color: color);
  }

  @override
  Widget buildAdd(BuildContext context) {
    return AddAppBarWidget(onClick: () => navigatorAdd(context));
  }

  @override
  Future<void> navigatorAdd(BuildContext context) async {
    var result = await Navigator.of(context).push(
      TransitionsBuilder.createRoute(
        RegisterRevisionPage(
          revision: Register(
            RevisionDatabaseDataSource(),
            Revision(),
            Message(),
            RegisterDateRevision(DateRevisionDatabaseDataSource(), DateRevision()),
          ),
        ),
      ),
    );

    if (result) reloadPage();
  }

  @override
  Color? color;
}
