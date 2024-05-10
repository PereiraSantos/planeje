import 'package:flutter/material.dart';
import 'package:planeje/annotation/pages/list_annotation/component/dialog_delete.dart';
import 'package:planeje/annotation/pages/register_annotation/pages/register_annotation.dart';
import 'package:planeje/revision/pages/list_revision/page/list_revision.dart';

import '../../../../dashboard/pages/home.dart';
import '../../../../quiz_revision/pages/list_quiz/page/list_quiz.dart';
import '../../../../usercase/format_date.dart';
import '../../../../usercase/transitions_builder.dart';
import '../../../../widgets/app_bar_widget.dart';
import '../../../entities/annotation_revision.dart';
import '../component/text_list.dart';
import '../component/view_annotation.dart';
import '../controller/list_annotation_controller.dart';

class ListAnnotation extends StatefulWidget {
  const ListAnnotation({super.key});

  @override
  State<ListAnnotation> createState() => _ListAnnotationState();
}

class _ListAnnotationState extends State<ListAnnotation> {
  final ListAnnotattionController listAnnotattionController = ListAnnotattionController();
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
          callBackQuiz: () => Navigator.of(context).push(TransitionsBuilder.createRoute(const ListQuiz())),
          callbackAdd: () async {
            var result = await Navigator.of(context).push(
              TransitionsBuilder.createRoute(RegisterAnnotation()),
            );

            if (result) reloadPage();
          },
          callbackFilter: () {
            reloadPage();
          },
          colorAnnotation: Colors.black54,
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: listAnnotattionController.getAnnotation(value: ''),
          builder: (BuildContext context, AsyncSnapshot<List<AnnotationRevision>> snapshot) {
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
                              context, snapshot.data![index], listAnnotattionController);
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
                                Visibility(
                                  visible: snapshot.data![index].idRevision != null ? true : false,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const TextList(
                                        "Revisão:",
                                        flex: 2,
                                      ),
                                      TextList(
                                        "${snapshot.data![index].description}",
                                        flex: 6,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10, top: 05),
                                        child: GestureDetector(
                                          onTap: () async {
                                            await ViewAnnotation.build(context, snapshot.data![index]);
                                          },
                                          child: const Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.black54,
                                            size: 22,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextList(snapshot.data![index].text ?? ""),
                                    Visibility(
                                      visible: snapshot.data![index].idRevision != null ? false : true,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10, top: 05),
                                        child: GestureDetector(
                                          onTap: () async {
                                            await ViewAnnotation.build(context, snapshot.data![index]);
                                          },
                                          child: const Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.black54,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                TextList.date(
                                    FormatDate().formatDateWek(snapshot.data![index].dateText ?? "")),
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
      ),
    );
  }
}
