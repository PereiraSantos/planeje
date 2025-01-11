import 'package:flutter/material.dart';
import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/learn/utils/find_learn.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/pages/list_revision/component/text_list.dart';
import 'package:planeje/utils/format_date.dart';

class CardRevision extends StatelessWidget {
  const CardRevision({
    super.key,
    required this.revisionTime,
    this.isRevision = false,
    this.child,
  });

  final RevisionTime revisionTime;
  final bool isRevision;
  final Widget? child;

  bool compareDate(String date, bool Function(DateTime, DateTime) compare) {
    DateTime nextDate = FormatDate.dateParse(date);
    DateTime result = DateTime.now();
    DateTime dateNow = DateTime(result.year, result.month, result.day);

    if (compare(nextDate, dateNow)) return true;
    return false;
  }

  Widget labelCard(String label) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, top: 2),
        child: Text(
          label,
          style: const TextStyle(color: Colors.black45, fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isRevision ? 1 : 5, top: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FutureBuilder(
            future: GetLearn(LearnDatabase()).getById(revisionTime.revision.id ?? -1),
            builder: (BuildContext context, AsyncSnapshot<Learn?> snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  width: double.maxFinite,
                  child: TextCard(
                    padding: const EdgeInsets.only(left: 15, right: 0, top: 2),
                    revisionEntity: '${snapshot.data?.description ?? ""} -  ${revisionTime.revision.description ?? ""}',
                    maxLines: 5,
                  ),
                );
              } else {
                return SizedBox(
                  width: double.maxFinite,
                  child: TextCard(
                    padding: const EdgeInsets.only(left: 15, right: 0, top: 2),
                    revisionEntity: revisionTime.revision.description ?? "",
                    maxLines: 5,
                  ),
                );
              }
            },
          ),
          /*  SizedBox(
            width: double.maxFinite,
            child: TextCard(
              padding: const EdgeInsets.only(left: 15, right: 0, top: 2),
              revisionEntity: revisionTime.dateRevision.nextDate != null ? FormatDate.formatDateString('${revisionTime.dateRevision.nextDate}') : '',
              maxLines: 5,
            ),
          ),*/
          child ?? const SizedBox(),
        ],
      ),
    );
  }
}
