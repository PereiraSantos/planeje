import 'package:planeje/entities/revision.dart';

import '../entities/date_revision.dart';
import '../usercase/format_date.dart';

class DateRevisionModel extends DateRevision {
  bool? delete;
  int? quantityDay;

  DateRevisionModel({
    this.delete = false,
    this.quantityDay,
    int? id,
    int? revisionId,
    String? date,
    bool? status,
  }) : super(
          id: id,
          revisionId: revisionId,
          date: date,
          status: status,
        );

  static List<DateRevisionModel> transformObject(List<DateRevision> dateRevision, Revision revision) {
    List<DateRevisionModel>? list = [];

    dateRevision
        .map((element) => list.add(
              DateRevisionModel(
                id: element.id,
                date: element.date,
                revisionId: element.revisionId,
                status: element.status,
                delete: false,
                quantityDay: FormatDate.dateParse(element.date!)
                    .difference(FormatDate.dateParse(revision.dateCriation!))
                    .inDays,
              ),
            ))
        .toList();

    return list;
  }
}
