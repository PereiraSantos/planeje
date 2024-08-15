import 'package:flutter/material.dart';
import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/pages/register_revision/page/register_revision_page.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/utils/type_message.dart';

import '../../revision/pages/list_revision/component/text_list.dart';
import '../../utils/transitions_builder.dart';
import '../../utils/format_date.dart';

class NextRevision extends StatelessWidget {
  const NextRevision({
    super.key,
    required this.future,
    required this.text,
    required this.finishUpdaterReviser,
  });

  final Future<List<RevisionTime>?> future;
  final String text;
  final Function() finishUpdaterReviser;

  Widget labelText(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 5),
      child: SizedBox(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black54,
          ),
        ),
      ),
    );
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
                const Padding(padding: EdgeInsets.all(10)),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
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
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          elevation: 2,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0), borderSide: BorderSide.none),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: TextCard(
                                  padding: const EdgeInsets.only(left: 8, top: 05, right: 5),
                                  revisionEntity: snapshot.data![index].revision.description ?? "",
                                  maxLines: 5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                width: double.maxFinite,
                                child: TextCard(
                                  padding: const EdgeInsets.only(left: 8, right: 5, bottom: 5, top: 5),
                                  revisionEntity: FormatDate.formatDateString(
                                      "${snapshot.data![index].dateRevision.nextDate}"),
                                  maxLines: 5,
                                ),
                              )
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
