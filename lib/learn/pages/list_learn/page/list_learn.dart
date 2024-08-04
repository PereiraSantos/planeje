import 'package:flutter/material.dart';
import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/learn/pages/register_learn/register_learn.dart';
import 'package:planeje/learn/utils/find_learn.dart';
import 'package:planeje/learn/utils/register_learn.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_notifier.dart';
import '../../../../utils/transitions_builder.dart';
import '../component/dialog_delete.dart';
import '../component/text_list.dart';

// ignore: must_be_immutable
class ListLearn extends StatelessWidget {
  ListLearn(this.learnNotifier, {super.key});

  Notifier learnNotifier;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: GetLearn(LearnDatabase()).getAllLearn(learnNotifier.search ?? ''),
        builder: (BuildContext context, AsyncSnapshot<List<Learn>?> snapshot) {
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
                              RegisterLearnPage(
                                registerLearn: UpdateLearn(
                                  LearnDatabase(),
                                  snapshot.data![index],
                                  Message(TypeMessage.Atualizar),
                                ),
                              ),
                            ),
                          );
                          if (result) learnNotifier.update();
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
