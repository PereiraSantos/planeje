import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/utils/register.dart';
import 'package:planeje/utils/type_message.dart';

abstract class RevisionFactory extends RegisterFactory {
  late Revision revision;
  late DateFactory registerDate;
}

class Register implements RevisionFactory {
  RevisionDatabaseFactory revisionDatabase;

  Register(this.revisionDatabase, this.revision, this.message, this.registerDate);

  @override
  Future<int?> write() async {
    return await revisionDatabase.insertRevision(revision);
  }

  @override
  Revision revision;

  @override
  StatusNotification message;

  @override
  DateFactory registerDate;
}

class Update implements RevisionFactory {
  RevisionDatabaseDataSource revisionDatabase;

  Update(this.revisionDatabase, this.revision, this.message, this.registerDate);

  @override
  Revision revision;

  @override
  Future<int?> write() async {
    return await revisionDatabase.updateRevision(revision);
  }

  @override
  StatusNotification message;

  @override
  DateFactory registerDate;
}
