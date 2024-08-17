import 'package:flutter/material.dart';
import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/pages/list_annotation/component/dialog_delete.dart';
import 'package:planeje/annotation/pages/list_annotation/component/filter.dart';
import 'package:planeje/annotation/pages/register_annotation/pages/register_annotation.dart';
import 'package:planeje/annotation/utils/filter_notifier.dart';
import 'package:planeje/annotation/utils/find_annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/category/datasource/database/datasource_category_repository.dart';
import 'package:planeje/category/entities/category.dart';
import 'package:planeje/category/utils/find_category.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_notifier.dart';
import '../../../../utils/transitions_builder.dart';

import '../../../entities/annotation_revision.dart';
import '../component/text_list.dart';

// ignore: must_be_immutable
class ListAnnotation extends StatelessWidget {
  ListAnnotation(this.annotationNotifier, {super.key});
  Notifier annotationNotifier;
  FilterNotifier filterNotifier = FilterNotifier();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future: GetCategory(CategoryDatabase()).getAllCategory(''),
            builder: (BuildContext context, AsyncSnapshot<List<Category>?> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? Filter(list: snapshot.data!, filterNotifier: filterNotifier)
                    : const SizedBox();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          FutureBuilder(
            future: GetAnnotation(AnnotationDatabase())
                .getAnnotationWidthRevision(annotationNotifier.search ?? ''),
            builder: (BuildContext context, AsyncSnapshot<List<AnnotationRevision>?> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  filterNotifier.setAnnotation(snapshot.data!);

                  return ListenableBuilder(
                    listenable: filterNotifier,
                    builder: (BuildContext context, Widget? child) {
                      List<AnnotationRevision> annotations = [];

                      var result = List<AnnotationRevision>.from(filterNotifier.annotation!);
                      int quantitySelect = 0;

                      for (Category item in filterNotifier.filter) {
                        if (item.select) {
                          quantitySelect++;
                          annotations.addAll(
                              result.where((e) => e.descriptionCategory == item.description).toList());
                        }
                      }

                      if (quantitySelect == 0 && annotations.isEmpty) annotations = result;
                      if (quantitySelect > 0 && annotations.isEmpty) annotations = [];

                      if (annotations.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Não há anotação!!!",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w300),
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: annotations.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            confirmDismiss: (DismissDirection direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                return await DialogDelete.build(context, annotations[index]);
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
                                          AnnotationDatabase(),
                                          annotations[index],
                                          Message(TypeMessage.Atualizar),
                                        ),
                                      ),
                                    ),
                                  );
                                  if (result) annotationNotifier.update();
                                },
                                child: Card(
                                  elevation: 2,
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3), borderSide: BorderSide.none),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: annotations[index].idRevision != null,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const TextList("Revisão:", flex: 2),
                                            TextList("${annotations[index].description}",
                                                flex: 6, fontSize: 17),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: annotations[index].idCategory != null &&
                                            annotations[index].descriptionCategory != null,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const TextList("Categoria:", flex: 2),
                                            TextList("${annotations[index].descriptionCategory}",
                                                flex: 6, fontSize: 17),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: annotations[index].title != "",
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            TextList(
                                              "${annotations[index].title}",
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextList(annotations[index].text ?? ""),
                                        ],
                                      ),
                                      const Padding(padding: EdgeInsets.all(3))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Não há anotação!!!",
                      style: TextStyle(fontSize: 22, color: Colors.black54, fontWeight: FontWeight.w300),
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
    );
  }
}
