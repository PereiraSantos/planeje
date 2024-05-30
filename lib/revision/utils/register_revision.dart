import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/utils/type_message.dart';

abstract class IRevision {
  Future<int?> writeRevision();
  late Revision revision;
  late Message message;
  late IDate registerDate;
}

class Register implements IRevision {
  RevisionDataSourceRepository databaseData;

  Register(this.databaseData, this.revision, this.message, this.registerDate);

  @override
  Future<int?> writeRevision() async {
    return await databaseData.insertRevision(revision);
  }

  @override
  Revision revision;

  @override
  Message message;

  @override
  IDate registerDate;
}

class Update implements IRevision {
  RevisionDatabaseDataSource databaseData;

  Update(this.databaseData, this.revision, this.message, this.registerDate);

  @override
  Revision revision;

  @override
  Future<int?> writeRevision() async {
    return await databaseData.updateRevision(revision);
  }

  @override
  Message message;

  @override
  IDate registerDate;
}
