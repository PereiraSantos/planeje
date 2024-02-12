import 'package:flutter_test/flutter_test.dart';

import 'package:planeje/revision/datasource/repository/datasource_revision_repository.dart';
import 'package:planeje/revision/entities/revision.dart';

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
  Future<List<Revision>> findRevisionByDescription(String text) async {
    return [Revision()];
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
  Future<int> updateRevision(String description, String nextDate, int id, bool status) async {
    return 1;
  }

  @override
  Future<Revision?> getNextRevision() {
    throw UnimplementedError();
  }

  @override
  Future<List<Revision>?> getCompletedRevision() {
    throw UnimplementedError();
  }

  @override
  Future<List<Revision>?> getDelayedRevision() {
    throw UnimplementedError();
  }
}

void main() {
  /* DatabaseMock database = DatabaseMock();
  test("Espero que cadastre um registro", () async {});*/
}
