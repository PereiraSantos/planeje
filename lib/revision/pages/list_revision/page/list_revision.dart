import 'package:flutter/material.dart';
import 'package:planeje/revision/pages/list_revision/component/list_revision_componet.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_notifier.dart';

// ignore: must_be_immutable
class ListRevision extends StatefulWidget {
  ListRevision(this.revisionNotifier, {super.key});
  Notifier revisionNotifier;

  @override
  State<ListRevision> createState() => _ListRevisionState();
}

class _ListRevisionState extends State<ListRevision> with SingleTickerProviderStateMixin {
  static const List<Tab> tabs = <Tab>[
    Tab(child: Text('Realizar', style: TextStyle(color: Colors.grey, fontSize: 16))),
    Tab(child: Text('Próximas', style: TextStyle(color: Colors.grey, fontSize: 16))),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          indicatorColor: Colors.grey,
          indicatorWeight: 1,
          padding: const EdgeInsets.only(left: 10, right: 10),
          controller: _tabController,
          tabs: tabs,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ListRevisionComponet(revisionNotifier: widget.revisionNotifier, next: true),
              ListRevisionComponet(revisionNotifier: widget.revisionNotifier),
            ],
          ),
        ),
      ],
    );
  }
}
