import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';

class RevisionTime {
  Revision revision;
  DateRevision dateRevision;
  bool isUnderReview = false;
  bool initTime = false;

  RevisionTime(this.revision, this.dateRevision);

  setUnderReview(bool value) => isUnderReview = value;
  setInitTime(bool value) => initTime = value;
}
