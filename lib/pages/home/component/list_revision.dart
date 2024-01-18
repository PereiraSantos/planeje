import 'package:flutter/material.dart';
import 'package:planeje/entities/revision.dart';
import '../../../entities/date_revision.dart';
import '../../../usercase/format_date.dart';
import '../../register_revision/component/check_box.dart';
import '../../register_revision/controller/revision_controller.dart';
import 'text_list.dart';

class ListRevision extends StatelessWidget {
  const ListRevision({
    Key? key,
    required this.controller,
    required this.onClickDelete,
    required this.onClickUpdate,
    required this.loadList,
    this.search,
  }) : super(key: key);

  final RevisionController controller;
  final Function(int) onClickDelete;
  final Function(Revision) onClickUpdate;
  final Function(int) loadList;
  final String? search;

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
      future: controller.getRevision(value: search),
      builder: (BuildContext context, AsyncSnapshot<List<Revision>> snapshot) {
        if (snapshot.hasData) {
          loadList(snapshot.data!.length);
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
                                      onPressed: () => onClickDelete(snapshot.data![index].id!),
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
                      onTap: () => onClickUpdate(snapshot.data![index]),
                      child: Card(
                        elevation: 8,
                        // color: getColor(snapshot.data![index]),

                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                        child: Column(
                          children: [
                            labelText("Revisão:"),
                            SizedBox(
                              width: double.maxFinite,
                              child: TextCard(
                                padding: const EdgeInsets.only(left: 8, top: 2, right: 5),
                                revisionEntity: snapshot.data![index].text ?? "",
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            labelText("Descrisão:"),
                            SizedBox(
                              width: double.maxFinite,
                              child: TextCard(
                                padding: const EdgeInsets.only(left: 8, top: 2, right: 5),
                                revisionEntity: snapshot.data![index].description ?? "",
                                maxLines: 5,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0, top: 5, bottom: 5),
                                    child: Text('Revisado em: ${snapshot.data![index].revision ?? ''}'),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0, top: 5, bottom: 5),
                                    child: Text('Revisar em: ${snapshot.data![index].nextRevision ?? ''}'),
                                  ),
                                )
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
    );
  }
}

nextRevision(BuildContext context, RevisionController controller, int id) {
  showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, top: 20),
                child: Text(
                  "Revisado",
                  style: TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 25.0),
              child: FutureBuilder(
                future: controller.getDateRevision(id),
                builder: (BuildContext context, AsyncSnapshot<List<DateRevision>> snapshotDateRevision) {
                  if (snapshotDateRevision.hasData) {
                    if (snapshotDateRevision.data!.isNotEmpty) {
                      return GridView.builder(
                        itemCount: snapshotDateRevision.data!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisExtent: 35,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Card(
                                elevation: 8,
                                color: snapshotDateRevision.data![index].status! ? Colors.white : Colors.red,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                    child: Text(
                                      '${snapshotDateRevision.data![index].date}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: snapshotDateRevision.data![index].status!
                                            ? Colors.black87
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              CheckBoxComponent(
                                isChecked: snapshotDateRevision.data![index].status,
                                onClick: (value) => controller.setValueListDay(
                                    id: snapshotDateRevision.data![index].id, status: value),
                                child: const SizedBox(),
                              )
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    return const SizedBox();
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
