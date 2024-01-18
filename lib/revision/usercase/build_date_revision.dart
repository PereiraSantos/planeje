import 'package:flutter/material.dart';
import 'package:planeje/usercase/format_date.dart';

import '../../entities/date_revision.dart';
import '../../model/date_revision_model.dart';

class BuildDateRevision {
  List<DateRevision> build(
    int id,
    nextRevision,
    List<DateRevisionModel> listDay,
    TimeOfDay selectedTime,
  ) {
    List<DateRevision> list = [];

    listDay.sort((a, b) => a.quantityDay!.compareTo(b.quantityDay!));

    for (var i = 0; i < listDay.length; i++) {
      list.add(
        DateRevision(
          revisionId: id,
          date: FormatDate.formatDateStringDb(nextRevision),
          hour: selectedTime.hour,
          minute: selectedTime.minute,
        ),
      );
    }

    return list;
  }
}
