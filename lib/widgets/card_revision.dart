import 'package:flutter/material.dart';
import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/learn/utils/find_learn.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/pages/list_revision/component/text_list.dart';
import 'package:planeje/utils/format_date.dart';
import 'package:planeje/widgets/button_widget.dart';

class CardRevision extends StatelessWidget {
  const CardRevision({
    super.key,
    required this.revisionTime,
    this.reloadPage,
    this.isRevision = false,
  });

  final RevisionTime revisionTime;
  final Function()? reloadPage;
  final bool isRevision;

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

  getTimeRevision() {
    if (revisionTime.dateRevision.hourInit == null || revisionTime.dateRevision.hourEnd == null) return '';
    DateTime timeInit = FormatDate.timeParse(revisionTime.dateRevision.hourInit!);
    DateTime timeEnd = FormatDate.timeParse(revisionTime.dateRevision.hourEnd!);

    var time = timeEnd.subtract(Duration(hours: timeInit.hour, minutes: timeInit.minute));

    return time.toString().replaceAll('1970-01-01', '').replaceAll('.000', '').trimLeft();
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
    return Card(
      elevation: 2,
      color: checkColorDate(revisionTime.dateRevision.nextDate),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: BorderSide.none,
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: isRevision ? 1 : 5, top: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
              future: GetLearn(LearnDatabase()).getLearnId(revisionTime.revision.idLearn ?? -1),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelCard('Revisão:'),
                Expanded(
                  flex: 8,
                  child: SizedBox(
                    width: double.maxFinite,
                    child: TextCard(
                      padding: const EdgeInsets.only(right: 0, top: 2),
                      revisionEntity: revisionTime.revision.description ?? "",
                      maxLines: 5,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelCard('Data:'),
                Expanded(
                  flex: 8,
                  child: SizedBox(
                    width: double.maxFinite,
                    child: TextCard(
                      padding: const EdgeInsets.only(right: 0, top: 2),
                      revisionEntity: revisionTime.dateRevision.nextDate != null
                          ? FormatDate.formatDateString('${revisionTime.dateRevision.nextDate}')
                          : '',
                      maxLines: 5,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                labelCard('Tempo:'),
                Expanded(
                  flex: 8,
                  child: TextCard(
                    padding: const EdgeInsets.only(right: 0, top: 2),
                    revisionEntity: '${getTimeRevision()}',
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isRevision,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Visibility(
                      visible: !revisionTime.isUnderReview,
                      replacement: SizedBox(
                        width: 70,
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 6, bottom: 6),
                          child: ButtonWidget(
                              onTap: () {
                                revisionTime.setUnderReview(false);
                                if (reloadPage != null) reloadPage!();
                              },
                              label: 'Finalizar'),
                        ),
                      ),
                      child: SizedBox(
                        width: 70,
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, top: 6, bottom: 6),
                          child: ButtonWidget(
                              onTap: () {
                                revisionTime.setUnderReview(true);
                                if (reloadPage != null) reloadPage!();
                              },
                              label: 'Iniciar'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: revisionTime.isUnderReview && revisionTime.initTime,
                          child: SizedBox(
                            width: 40,
                            height: 35,
                            child: IconButton(
                              onPressed: () {
                                revisionTime.setInitTime(false);
                                if (reloadPage != null) reloadPage!();
                              },
                              icon: const Icon(
                                Icons.pause,
                                size: 20,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: revisionTime.isUnderReview && !revisionTime.initTime,
                          child: SizedBox(
                            width: 40,
                            height: 35,
                            child: IconButton(
                              onPressed: () {
                                revisionTime.setInitTime(true);
                                if (reloadPage != null) reloadPage!();
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                                size: 20,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
