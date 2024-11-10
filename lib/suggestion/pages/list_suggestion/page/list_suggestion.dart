import 'package:flutter/material.dart';
import 'package:planeje/suggestion/datasource/database/suggestion_database.dart';
import 'package:planeje/suggestion/entities/suggestion.dart';
import 'package:planeje/suggestion/pages/list_suggestion/component/text_list.dart';
import 'package:planeje/suggestion/pages/register_suggestion/page/register_suggestion.dart';
import 'package:planeje/suggestion/utils/delete_suggestion.dart';
import 'package:planeje/suggestion/utils/find_suggestion.dart';
import 'package:planeje/suggestion/utils/register_suggestion.dart';
import 'package:planeje/suggestion/utils/suggestion_notifier.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/checkbox_custom.dart';
import 'package:planeje/widgets/dialog_delete.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_notifier.dart';

// ignore: must_be_immutable
class ListSuggestion extends StatelessWidget {
  ListSuggestion(this.suggestionNotifier, {super.key});

  Notifier suggestionNotifier;

  SuggestionNotifier suggestionNotifierList = SuggestionNotifier();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10, top: 05),
            child: ListenableBuilder(
              listenable: suggestionNotifierList,
              builder: (BuildContext context, Widget? child) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: suggestionNotifierList.showBotton,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          suggestionNotifierList.sortitionValue();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          "Sortear",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: suggestionNotifierList.sortition != null,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (suggestionNotifierList.sortition == null) return;

                          var result = await InsertSuggestion(SuggestionDatabaseDataSource(),
                                  StatusNotification(), suggestionNotifierList.sortition!)
                              .updateSortition();

                          if (result != null && context.mounted) {
                            suggestionNotifier.update();
                            MessageUser.message(context, 'Registrado com sucesso!!!');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          "Salvar",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: suggestionNotifierList.showBottonReset,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      height: 20,
                      child: ElevatedButton(
                        onPressed: () async {
                          Suggestion? result;
                          for (Suggestion item in suggestionNotifierList.suggestions) {
                            if (item.sortition ?? false) {
                              item.sortition = false;
                              result = await InsertSuggestion(
                                      SuggestionDatabaseDataSource(), StatusNotification(), item)
                                  .updateSortition();
                            }
                          }

                          if (result != null && context.mounted) {
                            suggestionNotifierList.resetSortition();
                            MessageUser.message(context, 'Resetado com sucesso!!!');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          "Resetar",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: GetSuggestion(SuggestionDatabaseDataSource()).getAll(suggestionNotifier.search ?? ''),
            builder: (BuildContext context, AsyncSnapshot<List<Suggestion>?> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  suggestionNotifierList.setList(snapshot.data!);

                  return ListenableBuilder(
                    listenable: suggestionNotifierList,
                    builder: (BuildContext context, Widget? child) => ListView.separated(
                      itemCount: suggestionNotifierList.suggestions.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const Divider(endIndent: 10, indent: 10);
                      },
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          confirmDismiss: (DismissDirection direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              return await DialogDelete().build(context, snapshot.data![index].description!,
                                  <Learn>() async {
                                try {
                                  return await DeleteSugestion(SuggestionDatabaseDataSource())
                                      .deleteById(snapshot.data![index].id!);
                                } catch (e) {
                                  // ignore: use_build_context_synchronously
                                  MessageUser.message(context, 'Erro ao abrir dialogo');
                                }
                              });
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
                                      RegisterSuggestion(
                                        registerSuggestion: UpdateSuggestion(
                                          SuggestionDatabaseDataSource(),
                                          StatusNotification(TypeMessage.Atualizar),
                                          snapshot.data![index],
                                        ),
                                      ),
                                    ),
                                  );
                                  if (result) suggestionNotifier.update();
                                } catch (e) {
                                  // ignore: use_build_context_synchronously
                                  MessageUser.message(context, 'Erro na rota sugestão');
                                }
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: TextCard(
                                        padding:
                                            const EdgeInsets.only(left: 15, top: 05, right: 5, bottom: 5),
                                        label: snapshot.data![index].description ?? "",
                                        maxLines: 5,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Visibility(
                                      visible: snapshot.data![index].sortition ?? false,
                                      child: const Icon(Icons.check, color: Colors.green),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: CheckBoxCustom(
                                      isChecked: snapshot.data![index].select,
                                      onClick: (value) {
                                        suggestionNotifierList.setSelectSuggestion(index, value ?? false);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Não há sugestão!!!",
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
