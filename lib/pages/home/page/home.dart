import 'package:flutter/material.dart';

import 'package:planeje/entities/revision.dart';
import 'package:planeje/revision/pages/regsiter_revision/page/register_revision.dart';

import '../../../entities/date_revision.dart';
import '../../../model/date_revision_model.dart';
import '../../../usercase/transitions_builder.dart';
import '../component/list_revision.dart';
import '../../register_revision/controller/revision_controller.dart';
import '../component/text_field_search.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var showFilter = false;
  final RevisionController controller = RevisionController();
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
          /* IconButton(
            onPressed: () async {
              MethodChannel methodChannel = const MethodChannel('alarm/koltin');

              try {
                await methodChannel.invokeMethod(
                  "stop",
                );
              } on PlatformException catch (e) {
                log("$e");
              }
            },
            icon: const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          )*/
        ],
        bottom: showFilter
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
            : null,
      ),
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: ListRevision(
            controller: controller,
            search: search,
            onClickDelete: (id) async {
              controller.deleteRevisionController(id, context);
              Navigator.pop(context);
              reloadPage();
            },
            onClickUpdate: (Revision revision) async {
              // List<DateRevision> dateRevision = await controller.getDateRevision(revision.id!);

              // ignore: use_build_context_synchronously
              var result = await Navigator.of(context).push(
                TransitionsBuilder.createRoute(
                  RegisterRevision(
                    revisionEntity: revision,
                    //  dateRevisionModel: DateRevisionModel.transformObject(dateRevision, revision),
                  ),
                ),
              );

              if (result) reloadPage();
            },
            loadList: (value) => sizeList = value),
      ),
    );
  }
}
