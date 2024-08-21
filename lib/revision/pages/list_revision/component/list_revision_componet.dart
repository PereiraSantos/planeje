import 'package:flutter/material.dart';
import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/learn/utils/find_learn.dart';
import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/pages/list_revision/component/dialog_delete.dart';
import 'package:planeje/revision/pages/list_revision/component/text_list.dart';
import 'package:planeje/revision/pages/register_revision/page/register_revision_page.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/utils/format_date.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_notifier.dart';

// ignore: must_be_immutable
class ListRevisionComponet extends StatelessWidget {
  ListRevisionComponet({super.key, required this.revisionNotifier, this.next = false});

  Notifier revisionNotifier;
  final bool next;

  Widget labelText(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 5),
      child: SizedBox(
        child: Text(
          label,
          style: const TextStyle(fontSize: 17, color: Colors.black54),
        ),
      ),
    );
  }

  Color? checkColorDate(String? date) {
    if (date == "") return null;

    var result = compareDate(date!, (nextDate, dateNow) => nextDate.isBefore(dateNow));
    if (result) return const Color.fromARGB(255, 250, 194, 190);

    result = compareDate(
        date, (nextDate, dateNow) => nextDate.day == dateNow.day && nextDate.month == dateNow.month);
    if (result) return const Color.fromARGB(255, 110, 184, 245);

    return null;
  }

  bool compareDate(String date, bool Function(DateTime, DateTime) compare) {
    DateTime nextDate = FormatDate.dateParse(date);
    DateTime result = DateTime.now();
    DateTime dateNow = DateTime(result.year, result.month, result.day);

    if (compare(nextDate, dateNow)) return true;
    return false;
  }

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
                                  Message(TypeMessage.Atualizar),
                                  UpdateDateRevision(
                                      DateRevisionDatabaseDataSource(), snapshot.data![index].dateRevision),
                                ),
                              ),
                            ),
                          );
                          if (result) revisionNotifier.update();
                        },
                        child: Card(
                          elevation: 2,
                          color: checkColorDate(snapshot.data![index].dateRevision.nextDate),
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3),
                            borderSide: BorderSide.none,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                future: GetLearn(LearnDatabase())
                                    .getById(snapshot.data![index].revision.idLearn ?? -1),
                                builder: (BuildContext context, AsyncSnapshot<Learn?> snapshot) {
                                  if (snapshot.hasData) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        labelText("Conhecimento:"),
                                        Expanded(
                                          flex: 2,
                                          child: SizedBox(
                                            width: double.maxFinite,
                                            child: TextCard(
                                              padding: const EdgeInsets.only(left: 8, top: 05, right: 5),
                                              revisionEntity: snapshot.data?.description ?? "",
                                              maxLines: 5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                child: TextCard(
                                  padding: const EdgeInsets.only(left: 8, top: 05, right: 5),
                                  revisionEntity: snapshot.data![index].revision.description ?? "",
                                  maxLines: 5,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: TextCard(
                                        padding: const EdgeInsets.only(left: 8, right: 5, bottom: 5, top: 5),
                                        revisionEntity: FormatDate.formatDateString(
                                            '${snapshot.data![index].dateRevision.nextDate}'),
                                        maxLines: 5,
                                      ),
                                    ),
                                  ),
                                  labelText("Das:"),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: TextCard(
                                        padding: const EdgeInsets.only(left: 8, right: 5, bottom: 5, top: 5),
                                        revisionEntity: snapshot.data![index].dateRevision.hourInit != null
                                            ? FormatDate.formatTimeString(
                                                '${snapshot.data![index].dateRevision.hourInit}')
                                            : '',
                                        maxLines: 5,
                                      ),
                                    ),
                                  ),
                                  labelText("As:"),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: TextCard(
                                        padding: const EdgeInsets.only(left: 8, right: 5, bottom: 5, top: 5),
                                        revisionEntity: snapshot.data![index].dateRevision.hourEnd != null
                                            ? FormatDate.formatTimeString(
                                                '${snapshot.data![index].dateRevision.hourEnd}')
                                            : '',
                                        maxLines: 5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
