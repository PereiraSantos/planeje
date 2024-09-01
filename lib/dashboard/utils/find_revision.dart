import 'package:planeje/dashboard/utils/next_revision_time.dart';
import 'package:planeje/dashboard/controller/reviser_notifier.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/utils/format_date.dart';

abstract class FindRevisionFactory {
  Future<void> getRevision();
  late ReviserNotifier reviserNotifier;
}

class GetDelayedRevision extends NetRevisionTime implements FindRevisionFactory {
  GetDelayedRevision(super.revisionValid, this.reviserNotifier);

  @override
  Future<void> getRevision() async {
    await findNextRevision();

    List<RevisionTime> nextRevisions = [];

    for (var element in revisions) {
      nextRevisions.add(element);
    }

    for (var element in nextRevisions) {
      if (revisionValid.validate(FormatDate.dateParse(element.dateRevision.nextDate!))) total++;
    }

    reviserNotifier.updateDelayed(total);
  }

  @override
  ReviserNotifier reviserNotifier;
}

class GetCompletedRevision extends NetRevisionTime implements FindRevisionFactory {
  GetCompletedRevision(super.revisionValid, this.reviserNotifier);

  @override
  Future<void> getRevision() async {
    await findNextRevision();
    List<RevisionTime> nextRevisions = [];

    for (var element in revisions) {
      if (revisionValid.validate(FormatDate.dateParse(element.dateRevision.nextDate!))) total++;

      nextRevisions.add(element);
    }

    reviserNotifier.updateQuantityCompleted(total);
  }

  @override
  ReviserNotifier reviserNotifier;
}
