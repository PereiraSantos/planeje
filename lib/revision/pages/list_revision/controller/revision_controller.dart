import 'package:planeje/annotation/datasource/database/database_datasource.dart';

import '../../../../annotation/entities/annotation.dart';
import '../../../../annotation/usercase/annotation_usercase.dart';
import '../../../../usercase/format_date.dart';
import '../../../datasource/database/revision_database_datasource.dart';
import '../../../entities/revision.dart';
import '../../../entities/revision_time.dart';
import '../../../usercase/revision_usercase.dart';

class RevisionListController {
  RevisionUsercase revisionUsercase = RevisionUsercase(RevisionDatabaseDataSource());
  AnnotationUsercase annotationUsercase = AnnotationUsercase(AnnotationDatabaseDatasource());

  Future<List<RevisionTime>> getRevision({String? value}) async =>
      await revisionUsercase.findRevisionByDescription('%$value%');

  /*Future<List<Revision>> findRevision({String? value}) async {
    List<Revision> listRevision = [];
    listRevision = value != null && value != ""
        ? await revisionUsercase.findRevisionByDescription('%$value%')
        : await revisionUsercase.findAllRevisions();

    return await updateRevisionStatus(listRevision);
  }*/

  Future<List<Revision>> updateRevisionStatus(List<Revision> listRevision) async {
    /*for (var i = 0; i < listRevision.length; i++) {
      var result = compareDate(listRevision[i].nextDate!, (nextDate, dateNow) => nextDate.isBefore(dateNow));
      if (result && listRevision[i].status!) {
        listRevision[i].status = false;
        await revisionUsercase.updateRevision(listRevision[i].description!, listRevision[i].nextDate!,
            listRevision[i].id!, listRevision[i].status!);
      }
    }*/
    return listRevision;
  }

  Future<bool> onClickDelete(int id) async {
    var result = await revisionUsercase.deleteRevisionById(id);
    if (result != null) return true;
    return false;
  }

  bool compareDate(String date, bool Function(DateTime, DateTime) compare) {
    DateTime nextDate = FormatDate().dateParse(date);
    DateTime result = DateTime.now();
    DateTime dateNow = DateTime(result.year, result.month, result.day);

    if (compare(nextDate, dateNow)) return true;
    return false;
  }

  Future<List<Annotation>?> getAnnotationByIdRevision(int idRevision) async {
    return await annotationUsercase.findAnnotationByIdRevision(idRevision);
  }
}
