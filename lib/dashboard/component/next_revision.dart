import 'package:flutter/material.dart';
import 'package:planeje/dashboard/controller/under_review_notifier.dart';
import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/pages/register_revision/page/register_revision_page.dart';
import 'package:planeje/revision/utils/find_date_revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/revision/utils/update_hour.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/button_widget.dart';

import '../../revision/pages/list_revision/component/text_list.dart';
import '../../utils/transitions_builder.dart';
import '../../utils/format_date.dart';

class NextRevision extends StatelessWidget {
  const NextRevision({
    super.key,
    required this.future,
    required this.text,
    required this.finishUpdaterReviser,
    required this.underReviewNotifier,
  });

  final Future<List<RevisionTime>?> future;
  final String text;
  final Function() finishUpdaterReviser;
  final UnderReviewNotifier underReviewNotifier;

  String getTime() => FormatDate.formatTimeByString(FormatDate.newDate());

  Future<void> updateStatus(int id) async {
    DateRevision? dateRevision =
        await FindDateRevision(DateRevisionDatabaseDataSource()).findDateRevisionById(id);

    if (dateRevision != null && (dateRevision.status ?? false)) {
      var result = await RegisterDateRevision(
          DateRevisionDatabaseDataSource(),
          DateRevision(
            status: false,
            dateRevision: dateRevision.dateRevision,
            nextDate: dateRevision.nextDate,
            idRevision: dateRevision.idRevision,
            day: dateRevision.day,
          )).writeDateRevision();

      underReviewNotifier.setIdDateRevision(result!).update();
    } else {
      await UpdateHour(DateRevisionDatabaseDataSource())
          .updateStatus(false, id)
          .whenComplete(() => underReviewNotifier.setIdDateRevision(id).update());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<RevisionTime>?> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Column(
              children: [
                const Divider(color: Colors.grey, endIndent: 15, indent: 15),
                Container(
                  padding: const EdgeInsets.only(left: 15, bottom: 5),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
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
                        if (result) finishUpdaterReviser();
                      },
                      child: Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.only(left: 25, right: 15),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 5, right: 5),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: TextCard(
                                        padding: const EdgeInsets.only(top: 2),
                                        revisionEntity: snapshot.data![index].revision.description ?? "",
                                        maxLines: 5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Visibility(
                                      visible: underReviewNotifier.getIdDateRevision() == -1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 2),
                                          child: SizedBox(
                                            width: 52,
                                            height: 18,
                                            child: ButtonWidget(
                                              onTap: () async =>
                                                  await updateStatus(snapshot.data![index].dateRevision.id!)
                                                      .whenComplete(() {
                                                finishUpdaterReviser();
                                              }),
                                              label: 'Revisar',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: TextCard(
                                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                                    revisionEntity: FormatDate.formatDateString(
                                        "${snapshot.data![index].dateRevision.nextDate}"),
                                    maxLines: 5,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }

          return const SizedBox();
        } else {
          return const SizedBox(
            width: 15,
            height: 15,
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 1),
            ),
          );
        }
      },
    );
  }
}
