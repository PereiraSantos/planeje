import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/entities/date_revision.dart';

abstract class FindDateRevisionFactory {
  Future<List<DateRevision>> findAllDateRevisions();
  Future<List<DateRevision>?> findAllDateRevisionSync();
  Future<DateRevision?> findDateRevisionByIdExternal(int idExternal);
}

class GetDateRevision implements FindDateRevisionFactory {
  DateRevisionDatabaseFactory dateRevisionDatabase;

  GetDateRevision(this.dateRevisionDatabase);

  @override
  Future<List<DateRevision>> findAllDateRevisions() async {
    return await dateRevisionDatabase.findAllDateRevisions();
  }

  @override
  Future<List<DateRevision>?> findAllDateRevisionSync() async {
    return await dateRevisionDatabase.findAllDateRevisionSync();
  }

  @override
  Future<DateRevision?> findDateRevisionByIdExternal(int idExternal) async {
    return await dateRevisionDatabase.findDateRevisionByIdExternal(idExternal);
  }
}
