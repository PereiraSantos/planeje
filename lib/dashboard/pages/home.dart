import 'package:flutter/material.dart';
import 'package:planeje/annotation/pages/list_annotation/pages/list_annotation.dart';
import 'package:planeje/revision/pages/register_revision/page/register_revision.dart';

import '../../revision/pages/list_revision/page/list_revision.dart';
import '../../usercase/transitions_builder.dart';
import '../../widgets/app_bar_widget.dart';
import '../component/reviser_late.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void reloadPage() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBarWidget(
          callbackHome: () => Navigator.of(context).push(TransitionsBuilder.createRoute(const Home())),
          callbackReviser: () =>
              Navigator.of(context).push(TransitionsBuilder.createRoute(const ListRevision())),
          callbackAnnotation: () =>
              Navigator.of(context).push(TransitionsBuilder.createRoute(const ListAnnotation())),
          callbackAdd: () async {
            var result = await Navigator.of(context).push(
              TransitionsBuilder.createRoute(
                RegisterRevision(),
              ),
            );

            if (result) reloadPage();
          },
          callbackFilter: () {
            reloadPage();
          },
          colorHome: Colors.black54,
          showAction: false,
          countReviserLate: 1,
        ),
      ),
      backgroundColor: const Color(0xffffffff),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ReviserLate(),
          ],
        ),
      ),
    );
  }
}
