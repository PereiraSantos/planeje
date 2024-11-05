import 'package:flutter/material.dart';
import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/pages/list_revision/component/dialog_delete.dart';
import 'package:planeje/revision/pages/register_revision/page/register_revision_page.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/card_revision.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_notifier.dart';

// ignore: must_be_immutable
class ListRevisionComponet extends StatelessWidget {
  ListRevisionComponet({super.key, required this.revisionNotifier, required this.isBefore});

  Notifier revisionNotifier;
  bool isBefore;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: GetRevision(RevisionDatabaseDataSource())
            .findRevisionByDescription(revisionNotifier.search ?? '', isBefore),
        builder: (BuildContext context, AsyncSnapshot<List<RevisionTime>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const Divider(endIndent: 10, indent: 10);
                },
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    confirmDismiss: (DismissDirection direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        try {
                          return await DialogDelete.build(context, snapshot.data![index].revision);
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
                                RegisterRevisionPage(
                                  revision: Update(
                                    RevisionDatabaseDataSource(),
                                    snapshot.data![index].revision,
                                    StatusNotification(TypeMessage.Atualizar),
                                    UpdateDateRevision(
                                        DateRevisionDatabaseDataSource(), snapshot.data![index].dateRevision),
                                  ),
                                ),
                              ),
                            );
                            if (result) revisionNotifier.update();
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            MessageUser.message(context, 'Erro na rota revisão');
                          }
                        },
                        child: CardRevision(revisionTime: snapshot.data![index]),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  "Não há revisão!!!",
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
