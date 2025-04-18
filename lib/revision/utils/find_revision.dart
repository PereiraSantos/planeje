import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';

abstract class FindRevisionFactory {
  Future<List<RevisionTime>> findRevisionByDescription(String text, bool isBefore, {int? limit});
  Future<int> getQuantiyRevision(String date, bool isBefore);
  Future<List<Revision>> findAllRevisions();
}

class GetRevision implements FindRevisionFactory {
  RevisionDatabaseFactory revisionDatabase;

  GetRevision(this.revisionDatabase);
  @override
  Future<List<RevisionTime>> findRevisionByDescription(String text, bool isBefore, {int? limit}) async {
    return await revisionDatabase.findRevisionByDescription(text, isBefore, limit: limit);
  }

  @override
  Future<int> getQuantiyRevision(String date, bool isBefore) async {
    return await revisionDatabase.getQuantiyRevision(date, isBefore);
  }

  @override
  Future<List<Revision>> findAllRevisions() async {
    return await revisionDatabase.findAllRevisions();
  }
}
