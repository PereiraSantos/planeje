import 'package:flutter/material.dart';
import 'package:planeje/annotation/pages/list_annotation/pages/list_annotation.dart';

import '../../../../dashboard/pages/home.dart';
import '../../../../usercase/format_date.dart';
import '../../../../usercase/transitions_builder.dart';
import '../../../../widgets/app_bar_widget.dart';
import '../../../entities/revision_time.dart';
import '../../register_revision/page/register_revision.dart';
import '../component/dialog_delete.dart';
import '../component/text_list.dart';
import '../controller/revision_controller.dart';

class ListRevision extends StatefulWidget {
  const ListRevision({super.key});

  @override
  State<ListRevision> createState() => _ListRevisionState();
}

class _ListRevisionState extends State<ListRevision> {
  final RevisionListController revisionController = RevisionListController();

  var showFilter = false;

  int sizeList = 0;

  String? search;

  void reloadPage() => setState(() {});

  Widget labelText(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 5),
      child: SizedBox(
        child: Text(
          label,
          style: const TextStyle(fontSize: 15, color: Colors.black54),
        ),
      ),
    );
  }

  void message(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Color? checkColorDate(String? date) {
    if (date == "") return null;

    var result = revisionController.compareDate(date!, (nextDate, dateNow) => nextDate.isBefore(dateNow));
    if (result) return const Color.fromARGB(255, 250, 194, 190);

    result = revisionController.compareDate(
        date, (nextDate, dateNow) => nextDate.day == dateNow.day && nextDate.month == dateNow.month);
    if (result) return const Color.fromARGB(255, 110, 184, 245);

    return null;
  }

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
            if (sizeList > 0) {
              showFilter = !showFilter;
              reloadPage();
            }
          },
          colorReviser: Colors.black54,
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: revisionController.getRevision(value: ''),
          builder: (BuildContext context, AsyncSnapshot<List<RevisionTime>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      confirmDismiss: (DismissDirection direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          return await DialogDelete.build(
                              context, revisionController, snapshot.data![index].revision);
                        }
                        return null;
                      },
                      background: const Align(
                        alignment: Alignment(-0.9, 0),
                        child: Icon(Icons.delete, color: Colors.red, size: 30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: GestureDetector(
                          onTap: () async {
                            var result = await Navigator.of(context).push(
                              TransitionsBuilder.createRoute(
                                RegisterRevision(revisionEntity: snapshot.data![index]),
                              ),
                            );
                            if (result) reloadPage();
                          },
                          child: Card(
                            elevation: 8,
                            color: checkColorDate(snapshot.data![index].dateRevision.dateRevision),
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    labelText("Descrição:"),
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        width: double.maxFinite,
                                        child: TextCard(
                                          padding: const EdgeInsets.only(left: 8, top: 05, right: 5),
                                          revisionEntity: snapshot.data![index].revision.description ?? "",
                                          maxLines: 5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    labelText("Criado em:"),
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        width: double.maxFinite,
                                        child: TextCard(
                                          padding: const EdgeInsets.only(left: 8, top: 05, right: 5),
                                          revisionEntity: FormatDate().formatDateString("01/01/2024"),
                                          maxLines: 5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    labelText("Revisa em:"),
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        width: double.maxFinite,
                                        child: TextCard(
                                          padding:
                                              const EdgeInsets.only(left: 8, right: 5, bottom: 5, top: 5),
                                          revisionEntity: FormatDate().formatDateString(
                                              '${snapshot.data![index].dateRevision.dateRevision}'),
                                          maxLines: 5,
                                        ),
                                      ),
                                    ),
                                    labelText("Das:"),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        width: double.maxFinite,
                                        child: TextCard(
                                          padding:
                                              const EdgeInsets.only(left: 8, right: 5, bottom: 5, top: 5),
                                          revisionEntity: FormatDate().formatTimeString(
                                              '${snapshot.data![index].dateRevision.hourInit}'),
                                          maxLines: 5,
                                        ),
                                      ),
                                    ),
                                    labelText("Até:"),
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        width: double.maxFinite,
                                        child: TextCard(
                                          padding:
                                              const EdgeInsets.only(left: 8, right: 5, bottom: 5, top: 5),
                                          revisionEntity: FormatDate().formatTimeString(
                                              '${snapshot.data![index].dateRevision.hourEnd}'),
                                          maxLines: 5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Container(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: const Text(
                    "Não há revisão!!!",
                    style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w300),
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
