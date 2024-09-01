import 'package:flutter/material.dart';

import 'package:planeje/dashboard/controller/under_review_notifier.dart';
import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/pages/list_revision/component/text_list.dart';
import 'package:planeje/revision/utils/update_hour.dart';
import 'package:planeje/utils/format_date.dart';
import 'package:planeje/widgets/button_widget.dart';

class ButtonTimeRevision extends StatelessWidget {
  const ButtonTimeRevision({
    super.key,
    required this.revisionTime,
    required this.underReviewNotifier,
    required this.finishReviser,
  });

  final RevisionTime revisionTime;
  final UnderReviewNotifier underReviewNotifier;
  final Function() finishReviser;

  String getTime() => FormatDate.formatTimeByString(FormatDate.newDate());

  Widget labelCard(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 0),
      child: Text(
        label,
        style: const TextStyle(color: Colors.black45, fontSize: 16),
      ),
    );
  }

  String nextRevision(String date, int day) {
    DateTime dateTemp;

    if (date == '') date = FormatDate.formatDate(DateTime.now());

    dateTemp = FormatDate.dateParse(date);
    dateTemp = dateTemp.add(Duration(days: day));

    return FormatDate.formatDate(dateTemp);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Visibility(
            visible: revisionTime.dateRevision.hourInit != null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelCard('Próxima:'),
                Expanded(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: TextCard(
                      padding: const EdgeInsets.only(top: 0, left: 5),
                      revisionEntity: FormatDate.formatDateString(
                          nextRevision(revisionTime.dateRevision.nextDate!, revisionTime.dateRevision.day!)),
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Visibility(
            visible:
                !(revisionTime.dateRevision.status ?? false) && revisionTime.dateRevision.hourInit == null,
            replacement: Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 85,
                height: 28,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 6),
                  child: ButtonWidget(
                      onTap: () async {
                        await UpdateHour(DateRevisionDatabaseDataSource()).updateHourEnd(
                            getTime(),
                            revisionTime.dateRevision.nextDate!,
                            nextRevision(revisionTime.dateRevision.nextDate!, revisionTime.dateRevision.day!),
                            revisionTime.dateRevision.id!);
                        await UpdateHour(DateRevisionDatabaseDataSource())
                            .updateStatus(true, revisionTime.dateRevision.id!)
                            .whenComplete(() {
                          underReviewNotifier.resetIdDateRevision();
                          finishReviser();
                        });
                      },
                      label: 'Finalizar'),
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 85,
                height: 28,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 6),
                  child: ButtonWidget(
                      onTap: () async {
                        await UpdateHour(DateRevisionDatabaseDataSource())
                            .updateHourInit(getTime(), revisionTime.dateRevision.id!)
                            .whenComplete(() => underReviewNotifier.update());
                      },
                      label: 'Iniciar'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
