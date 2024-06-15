import 'package:flutter/material.dart';
import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/pages/list_annotation/component/dialog_delete.dart';
import 'package:planeje/annotation/pages/register_annotation/pages/register_annotation.dart';
import 'package:planeje/annotation/utils/find_annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/utils/app_bar/annotation_app_bar.dart';
import 'package:planeje/utils/app_bar/home_app_bar.dart';
import 'package:planeje/utils/app_bar/quiz_app_bar.dart';
import 'package:planeje/utils/app_bar/revision_app_bar.dart';
import 'package:planeje/utils/format_date.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/text_form_field_widget.dart';
import '../../../../utils/transitions_builder.dart';
import '../../../../widgets/app_bar_widget/app_bar_widget.dart';
import '../../../entities/annotation_revision.dart';
import '../component/text_list.dart';
import '../component/view_annotation.dart';

class ListAnnotation extends StatefulWidget {
  const ListAnnotation({super.key});

  @override
  State<ListAnnotation> createState() => _ListAnnotationState();
}

class _ListAnnotationState extends State<ListAnnotation> {
  var showFilter = false;
  final TextEditingController controller = TextEditingController();

  void reloadPage() => setState(() {});

  void hideFilter() {
    showFilter = !showFilter;
    if (!showFilter) controller.text = '';
    reloadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBarWidget(
          actions: [
            AnnotationAppBar(onClick: hideFilter).buildIcon(context),
            AnnotationAppBar(onClick: reloadPage).buildAdd(context)
          ],
          child: [
            HomeAppBar().build(context),
            RevisionAppBar(onClick: reloadPage).build(context),
            AnnotationAppBar(onClick: reloadPage, color: Colors.black54).build(context),
            QuizAppBar(onClick: reloadPage).build(context),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: showFilter,
              child: TextFormFieldWidget(
                controller: controller,
                hintText: 'Filtra anotação',
                valid: false,
                onChange: (v) => reloadPage(),
              ),
            ),
            FutureBuilder(
              future:
                  GetAnnotation(AnnotationDatabaseDatasource()).getAnnotationWidthRevision(controller.text),
              builder: (BuildContext context, AsyncSnapshot<List<AnnotationRevision>?> snapshot) {
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
                              return await DialogDelete.build(context, snapshot.data![index]);
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
                                    RegisterAnnotation(
                                      registerAnnotation: UpdateAnnotation(
                                        AnnotationDatabaseDatasource(),
                                        snapshot.data![index],
                                        Message(TypeMessage.Atualizar),
                                      ),
                                    ),
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
                                        FormatDate.formatDateWek(snapshot.data![index].dateText ?? "")),
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
          ],
        ),
      ),
    );
  }
}
