import 'package:flutter/material.dart';
import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/pages/list_revision/component/dialog_delete.dart';
import 'package:planeje/revision/pages/register_revision/page/register_revision_page.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/utils/format_date.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/card_revision.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_notifier.dart';

// ignore: must_be_immutable
class ListRevisionComponet extends StatelessWidget {
  ListRevisionComponet({super.key, required this.revisionNotifier, this.next = false});

  Notifier revisionNotifier;
  final bool next;

  int getDateNext(String date, int id) {
    DateTime nextDate = FormatDate.dateParse(date).subtract(const Duration(days: 5));
    if (!next) {
      if (nextDate.isAfter(DateTime.now())) return -1;
    } else {
      if (nextDate.isBefore(DateTime.now())) return -1;
    }

    return id;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: GetRevision(RevisionDatabaseDataSource())
            .findRevisionByDescription(revisionNotifier.search ?? ''),
        builder: (BuildContext context, AsyncSnapshot<List<RevisionTime>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              snapshot.data!.removeWhere(
                  (item) => item.revision.id == getDateNext(item.dateRevision.nextDate!, item.revision.id!));

              return ListView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    confirmDismiss: (DismissDirection direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        return await DialogDelete.build(context, snapshot.data![index].revision);
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
