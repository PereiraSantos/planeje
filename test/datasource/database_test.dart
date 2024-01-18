import 'package:flutter_test/flutter_test.dart';
import 'package:planeje/entities/date_revision.dart';
import 'package:planeje/entities/revision.dart';
import 'package:planeje/revision/datasource/repository/datasource_revision_repository.dart';

class DatabaseMock implements IDataSourceRevisionRepository {
  DatabaseMock();

  @override
  Future<DateRevision?> deleteDateRevisionById(int id) async {
    return DateRevision();
  }

  @override
  Future<DateRevision?> deleteDateRevisionByIdRevision(int id, String date) async {
    return DateRevision();
  }

  @override
  Future<List<DateRevision>> findAllDateRevisions() async {
    return [DateRevision()];
  }

  @override
  Future<List<DateRevision>> findDateRevisionById(int id) async {
    return [DateRevision()];
  }

  @override
  Future<DateRevision?> findDateRevisionByIdRevision(int id, String date) async {
    return DateRevision();
  }

  @override
  Future<int> insertDateRevision(DateRevision dateRevision) async {
    return 1;
  }

  @override
  Future<int> insertDateRevisionList(List<DateRevision> dateRevision) async {
    return 1;
  }

  @override
  Future<DateRevision?> updateDateRevisionById(bool status, int id) async {
    return DateRevision();
  }

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
  Future<int> updateRevision(String description, int id, bool status) async {
    return 1;
  }
}

void main() {
  DatabaseMock database = DatabaseMock();
  test("Espero que cadastre um registro", () async {
    var result = await database
        .insertDateRevision(DateRevision(id: 1, date: '2024', hour: 21, minute: 30, revisionId: 1));
    expect(result, equals(1));
  });
}
