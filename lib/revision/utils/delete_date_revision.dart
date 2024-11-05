import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';

abstract class DeleteDateRevisionFactory {
  Future<void> deleteDateRevisionByIdRevision(int idRevision);
}

class DeleteDateRevision implements DeleteDateRevisionFactory {
  DateRevisionDatabaseFactory dateRevisionDatabaseFactory;

  DeleteDateRevision(this.dateRevisionDatabaseFactory);

  @override
  Future<void> deleteDateRevisionByIdRevision(int idRevision) async {
    return await dateRevisionDatabaseFactory.deleteDateRevisionByIdRevision(idRevision);
  }
}
