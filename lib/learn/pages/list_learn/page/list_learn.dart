import 'package:flutter/material.dart';
import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/learn/pages/register_learn/register_learn.dart';
import 'package:planeje/learn/utils/delete_learn.dart';
import 'package:planeje/learn/utils/find_learn.dart';
import 'package:planeje/learn/utils/register_learn.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_notifier.dart';
import '../../../../utils/transitions_builder.dart';
import '../../../../widgets/dialog_delete.dart';
import '../component/text_list.dart';

// ignore: must_be_immutable
class ListLearn extends StatelessWidget {
  ListLearn(this.learnNotifier, {super.key});

  Notifier learnNotifier;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: GetLearn(LearnDatabase()).getAll(learnNotifier.search ?? ''),
        builder: (BuildContext context, AsyncSnapshot<List<Learn>?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.separated(
                itemCount: snapshot.data!.length,
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
                            return await DeleteLearn(LearnDatabase()).deleteById(snapshot.data![index].id!);
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
                                RegisterLearnPage(
                                  registerLearn: UpdateLearn(
                                    LearnDatabase(),
                                    snapshot.data![index],
                                    StatusNotification(TypeMessage.Atualizar),
                                  ),
                                ),
                              ),
                            );
                            if (result) learnNotifier.update();
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            MessageUser.message(context, 'Erro na rota assunto');
                          }
                        },
                        child: SizedBox(
                          width: double.maxFinite,
                          child: TextCard(
                            padding: const EdgeInsets.only(left: 15, top: 05, right: 5, bottom: 5),
                            label: snapshot.data![index].description ?? "",
                            maxLines: 5,
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
                  "Não há item!!!",
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
