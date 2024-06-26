import 'package:flutter_test/flutter_test.dart';
import 'package:planeje/revision/datasource/database/revision_database_datasource.dart';

import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';

class DatabaseMock implements RevisionDataSourceRepository {
  DatabaseMock();

  @override
  Future<Revision?> deleteRevisionById(int id) async {
    return Revision();
  }

  @override
  Future<List<Revision>> findAllRevisions() async {
    return [Revision()];
  }

  @override
  Future<List<RevisionTime>> findRevisionByDescription(String text) async {
    return [RevisionTime(Revision(), DateRevision())];
  }

  @override
  Future<Revision?> findRevisionById(int id) async {
    return Revision();
  }

  @override
  Future<int> insertRevision(Revision revision) async {
    return 1;
  }

  @override
  Future<int?> updateRevision(Object revision) {
    throw UnimplementedError();
  }
}

void main() {
  /* DatabaseMock database = DatabaseMock();
  test("Espero que cadastre um registro", () async {});*/
}
