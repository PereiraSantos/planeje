import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';

abstract class FindRevisionFactory {
  Future<List<RevisionTime>> findRevisionByDescription(text, {bool? isBefore, String? date});
  Future<int> getQuantiyRevision(String date, bool isBefore);
}

class GetRevision implements FindRevisionFactory {
  RevisionDatabaseFactory revisionDatabase;

  GetRevision(this.revisionDatabase);
  @override
  Future<List<RevisionTime>> findRevisionByDescription(text, {bool? isBefore, String? date}) async {
    return await revisionDatabase.findRevisionByDescription(text, isBefore: isBefore, date: date);
  }

  @override
  Future<int> getQuantiyRevision(String date, bool isBefore) async {
    return await revisionDatabase.getQuantiyRevision(date, isBefore);
  }
}
