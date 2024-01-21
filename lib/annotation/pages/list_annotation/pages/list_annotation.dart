import 'package:flutter/material.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/pages/register_annotation/pages/register_annotation.dart';
import 'package:planeje/revision/pages/list_revision/page/list_revision.dart';

import '../../../../dashboard/pages/home.dart';
import '../../../../usercase/format_date.dart';
import '../../../../usercase/transitions_builder.dart';
import '../../../../widgets/app_bar_widget.dart';
import '../component/text_list.dart';
import '../controller/list_annotation_controller.dart';

class ListAnnotation extends StatefulWidget {
  const ListAnnotation({super.key});

  @override
  State<ListAnnotation> createState() => _ListAnnotationState();
}

class _ListAnnotationState extends State<ListAnnotation> {
  final ListAnnotattionController listAnnotattionController = ListAnnotattionController();
  void reloadPage() => setState(() {});

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
          callbackAnnotation: () {},
          callbackAdd: () async {
            var result = await Navigator.of(context).push(
              TransitionsBuilder.createRoute(
                RegisterAnnotation(),
              ),
            );

            if (result) reloadPage();
          },
          callbackFilter: () {
            reloadPage();
          },
          colorAnnotation: Colors.black54,
        ),
      ),
      body: FutureBuilder(
        future: listAnnotattionController.getAnnotation(value: ''),
        builder: (BuildContext context, AsyncSnapshot<List<Annotation>> snapshot) {
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
                                        onPressed: () async {
                                          var result = await listAnnotattionController
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
                                        onPressed: () => Navigator.of(context).pop(false),
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
                              RegisterAnnotation(annotation: snapshot.data![index]),
                            ),
                          );
                          if (result) reloadPage();
                        },
                        child: Card(
                          elevation: 8,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextList(snapshot.data![index].text ?? ""),
                                ],
                              ),
                              TextList.date(FormatDate().formatDateWek(snapshot.data![index].dateText ?? "")),
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
                  "Não há anotação!!!",
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
