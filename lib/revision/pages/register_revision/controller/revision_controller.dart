import 'package:flutter/material.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/usercase/revision_usercase.dart';

import '../../../../usercase/format_date.dart';
import '../../../datasource/database/date_revision_database_datasource.dart';
import '../../../entities/date_revision.dart';
import '../../../entities/revision.dart';
import '../../../usercase/date_revision_usercase.dart';

class RevisionRegisterController {
  RevisionUsercase revisionUsercase = RevisionUsercase(RevisionDatabaseDataSource());
  DateRevisionUsercase dateRevisionUsercase = DateRevisionUsercase(DateRevisionDatabaseDataSource());

  bool status = false;

  void setStatus(bool value) => status = value;

  Future<int?> saveOrUpdate({required Revision revision, required bool update}) async {
    var result = update
        ? await revisionUsercase.updateRevision(revision)
        : await revisionUsercase.insertRevision(revision);

    return result;
  }

  Future<int> saveDateRevision(DateRevision dateRevision, bool update) async {
    var result = update
        ? await dateRevisionUsercase.updateDateRevision(dateRevision)
        : await dateRevisionUsercase.insertDateRevision(dateRevision);
    return result;
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

  void message(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
