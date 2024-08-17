import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/utils/type_message.dart';

abstract class RevisionFactory {
  Future<int?> writeRevision();
  late Revision revision;
  late Message message;
  late DateFactory registerDate;
}

class Register implements RevisionFactory {
  RevisionDatabaseFactory revisionDatabase;

  Register(this.revisionDatabase, this.revision, this.message, this.registerDate);

  @override
  Future<int?> writeRevision() async {
    return await revisionDatabase.insertRevision(revision);
  }

  @override
  Revision revision;

  @override
  Message message;

  @override
  DateFactory registerDate;
}

class Update implements RevisionFactory {
  RevisionDatabaseDataSource revisionDatabase;

  Update(this.revisionDatabase, this.revision, this.message, this.registerDate);

  @override
  Revision revision;

  @override
  Future<int?> writeRevision() async {
    return await revisionDatabase.updateRevision(revision);
  }

  @override
  Message message;

  @override
  DateFactory registerDate;
}
