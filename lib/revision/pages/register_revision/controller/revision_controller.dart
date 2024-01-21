import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/usercase/revision_usercase.dart';

import '../../../usercase/build_revision.dart';

class RevisionRegisterController {
  RevisionUsercase revisionUsercase = RevisionUsercase(RevisionDatabaseDataSource());
  BuildRevision buildRevision = BuildRevision();

  bool status = false;

  Future<bool> saveOrUpdate(String description, {int? id}) async {
    var result = id != null
        ? await revisionUsercase.updateRevision(description, id, status)
        : await revisionUsercase.insertRevision(buildRevision.build(description: description));

    return result != null ? true : false;
  }
}
