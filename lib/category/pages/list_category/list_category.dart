import 'package:flutter/material.dart';
import 'package:planeje/category/datasource/database/datasource_category_repository.dart';
import 'package:planeje/category/entities/category.dart';
import 'package:planeje/category/pages/register_category/register_category.dart';
import 'package:planeje/category/utils/delete_category.dart';
import 'package:planeje/category/utils/find_category.dart';
import 'package:planeje/category/utils/register_category.dart';
import 'package:planeje/revision/pages/list_revision/component/text_list.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_notifier.dart';

import '../../../widgets/dialog_delete.dart';

// ignore: must_be_immutable
class ListCategory extends StatelessWidget {
  ListCategory(this.categoryNotifier, {super.key});

  Notifier categoryNotifier;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: GetCategory(CategoryDatabase()).getAll(categoryNotifier.search ?? ''),
        builder: (BuildContext context, AsyncSnapshot<List<Category>?> snapshot) {
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
                        try {
                          return await DialogDelete().build(
                            context,
                            snapshot.data![index].description!,
                            <Category>() async {
                              return await DeleteCategory(CategoryDatabase())
                                  .deleteById(snapshot.data![index].id!);
                            },
                          );
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          MessageUser.message(context, 'Erro ao abrir dialogo');
                        }
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
                          try {
                            var result = await Navigator.of(context).push(
                              TransitionsBuilder.createRoute(
                                RegisterCategoryPage(
                                  registerCategory: UpdateCategory(
                                    CategoryDatabase(),
                                    snapshot.data![index],
                                    StatusNotification(TypeMessage.Atualizar),
                                  ),
                                ),
                              ),
                            );
                            if (result) categoryNotifier.update();
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            MessageUser.message(context, 'Erro na rota categoria');
                          }
                        },
                        child: Card(
                          elevation: 2,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide.none,
                          ),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: TextCard(
                              padding: const EdgeInsets.only(left: 8, top: 05, right: 5, bottom: 5),
                              revisionEntity: snapshot.data![index].description ?? "",
                              maxLines: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  "Não há categoria!!!",
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
    );
  }
}
