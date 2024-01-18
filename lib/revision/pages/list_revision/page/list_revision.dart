import 'package:flutter/material.dart';
import 'package:planeje/entities/revision.dart';

import '../../../../usercase/format_date.dart';
import '../component/text_list.dart';
import '../controller/revision_controller.dart';

class ListRevision extends StatelessWidget {
  ListRevision({
    Key? key,
  }) : super(key: key);

  final RevisionListController revisionController = RevisionListController();

  Widget labelText(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 5),
      child: SizedBox(
        width: double.maxFinite,
        child: Text(
          label,
          style: const TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ),
    );
  }

  Color getColor(Revision value) {
    if (!value.status! && compareDate(value.nextRevision!)) {
      return const Color.fromARGB(255, 247, 139, 139);
    }
    if (value.status!) {
      return const Color.fromARGB(255, 129, 236, 185);
    }
    return Colors.white;
  }

  bool compareDate(String date) => FormatDate.dateParse(date).isBefore(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                              "Deseja excluir? \n${snapshot.data![index].text!}",
                              style: const TextStyle(color: Colors.black45, fontSize: 20),
                            ),
                            actions: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          revisionController.onClickDelete(snapshot.data![index].id!),
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: GestureDetector(
                      onTap: () => revisionController.onClickUpdate(snapshot.data![index]),
                      child: Card(
                        elevation: 8,
                        // color: getColor(snapshot.data![index]),

                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                        child: Column(
                          children: [
                            labelText("Descrisão:"),
                            SizedBox(
                              width: double.maxFinite,
                              child: TextCard(
                                padding: const EdgeInsets.only(left: 8, top: 2, right: 5),
                                revisionEntity: snapshot.data![index].description ?? "",
                                maxLines: 5,
                              ),
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
    );
  }
}
