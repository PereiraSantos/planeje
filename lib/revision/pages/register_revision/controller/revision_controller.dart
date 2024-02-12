import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/usercase/revision_usercase.dart';

import '../../../../usercase/format_date.dart';
import '../../../usercase/build_revision.dart';

class RevisionRegisterController {
  RevisionUsercase revisionUsercase = RevisionUsercase(RevisionDatabaseDataSource());
  BuildRevision buildRevision = BuildRevision();

  bool status = false;

  void setStatus(bool value) => status = value;

  Future<bool> saveOrUpdate(String description, String nextDate, String? timeInit, String? timeEnd,
      {int? id}) async {
    var result = id != null
        ? await revisionUsercase.updateRevision(description, nextDate, id, status)
        : await revisionUsercase.insertRevision(buildRevision.build(
            description: description,
            nextDate: nextDate,
            timeInit: intiTimeInit(timeInit),
            timeEnd: initTimrEnd(timeEnd),
          ));

    return result != null ? true : false;
  }

  String intiTimeInit(String? timeInit) {
    if (timeInit != null && timeInit != "") return timeInit;
    return FormatDate().formatTime(DateTime.now());
  }

  String initTimrEnd(String? timeEnd) {
    if (timeEnd != null && timeEnd != "") return timeEnd;
    return FormatDate().formatTime(DateTime.now());
  }

  String nextRevision(String date) {
    DateTime dateTemp;

    if (date == '') date = FormatDate().formatDate(DateTime.now());

    dateTemp = FormatDate().dateParse(date);
    dateTemp = dateTemp.add(const Duration(days: 30));

    return FormatDate().formatDate(dateTemp);
  }
}
