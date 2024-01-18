import 'package:flutter/material.dart';

import 'package:planeje/entities/revision.dart';
import 'package:planeje/pages/home/component/text_field_search.dart';
import 'package:planeje/revision/pages/regsiter_revision/page/register_revision.dart';

import '../../revision/pages/list_revision/page/list_revision.dart';
import '../../usercase/transitions_builder.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var showFilter = false;
  int sizeList = 0;
  String? search;
  void reloadPage() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //0xfff5c060
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: const Text(
          "Revisões",
          style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var result = await Navigator.of(context).push(
                TransitionsBuilder.createRoute(
                  RegisterRevision(),
                ),
              );

              if (result) reloadPage();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black54,
            ),
          ),
          IconButton(
            onPressed: () {
              if (sizeList > 0) {
                showFilter = !showFilter;
                reloadPage();
              }
            },
            icon: const Icon(
              Icons.filter_alt_rounded,
              color: Colors.black54,
            ),
          ),
        ],
        /* bottom: showFilter
            ? PreferredSize(
                preferredSize: const Size.fromHeight(70.0),
                child: Visibility(
                  visible: showFilter,
                  child: TextFieldSearch(
                    controller: controller,
                    onFieldSubmit: (value) => setState(() {
                      search = value;
                    }),
                  ),
                ),
              )
            : null,*/
      ),
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(child: ListRevision()),
    );
  }
}
