import 'package:flutter/material.dart';
import 'package:planeje/annotation/pages/list_annotation/pages/list_annotation.dart';

import '../../../../dashboard/pages/home.dart';
import '../../../../usercase/format_date.dart';
import '../../../../usercase/transitions_builder.dart';
import '../../../../widgets/app_bar_widget.dart';
import '../../../entities/revision.dart';
import '../../register_revision/page/register_revision.dart';
import '../component/text_list.dart';
import '../controller/revision_controller.dart';

class ListRevision extends StatefulWidget {
  const ListRevision({
    Key? key,
  }) : super(key: key);

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
          style: const TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ),
    );
  }

  Color getColor(Revision value) {
    if (value.status!) {
      return const Color.fromARGB(255, 129, 236, 185);
    }
    return Colors.white;
  }

  bool compareDate(String date) => FormatDate().dateParse(date).isBefore(DateTime.now());

  void message(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      body: FutureBuilder(
        future: revisionController.getRevision(value: ''),
        builder: (BuildContext context, AsyncSnapshot<List<Revision>> snapshot) {
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
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                "Deseja excluir? \n${snapshot.data![index].description!}",
                                style: const TextStyle(color: Colors.black45, fontSize: 20),
                              ),
                              actions: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          var result = await revisionController
                                              .onClickDelete(snapshot.data![index].id!);
                                          if (result && context.mounted) {
                                            message(context, 'Removido com sucesso');
                                            Navigator.pop(context, true);
                                          }
                                        },
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                            const BorderSide(width: 2, color: Color.fromARGB(80, 0, 0, 0)),
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                          ),
                                          textStyle: MaterialStateProperty.all(
                                            const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        child: const Text("SIM"),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                            const BorderSide(width: 2, color: Color.fromARGB(80, 0, 0, 0)),
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                                          ),
                                          textStyle: MaterialStateProperty.all(
                                            const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        child: const Text("NÃO"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
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
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  labelText("Descrisão:"),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: TextCard(
                                        padding: const EdgeInsets.only(left: 8, top: 2, right: 5),
                                        revisionEntity: snapshot.data![index].description ?? "",
                                        maxLines: 5,
                                      ),
                                    ),
                                  ),
                                ],
                              )
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
    );
  }
}
