import 'package:planeje/revision/entities/date_revision.dart';

import '../datasource/database/date_revision_database_datasource.dart';
import '../repository/date_revision_repository.dart';

class DateRevisionUsercase implements DateRevisionRepository {
  final DateRevisionDatabaseDataSource dateRevisionDatabaseDataSource;

  DateRevisionUsercase(this.dateRevisionDatabaseDataSource);

  @override
  Future<DateRevision?> deleteDateRevisionById(int id) async {
    return await dateRevisionDatabaseDataSource.deleteDateRevisionById(id);
  }

  @override
  Future<List<DateRevision>> findAllDateRevisions() async {
    return await dateRevisionDatabaseDataSource.findAllDateRevisions();
  }

  @override
  Future<DateRevision?> findDateRevisionById(int id) async {
    return await dateRevisionDatabaseDataSource.findDateRevisionById(id);
  }

  @override
  Future<int> insertDateRevision(DateRevision dateRevision) async {
    return await dateRevisionDatabaseDataSource.insertDateRevision(dateRevision);
  }

  DateRevision builddateRevision({
    required String daRevision,
    required String hourInit,
    required String hourEnd,
    required String nextDate,
    required int idRevision,
    int? id,
  }) {
    return DateRevision(
      id: id,
      dateRevision: daRevision,
      hourInit: hourInit,
      hourEnd: hourEnd,
      nextDate: nextDate,
      idRevision: idRevision,
    );
  }

  @override
  Future<int> updateDateRevision(DateRevision dateRevision) async {
    return await dateRevisionDatabaseDataSource.updateDateRevision(dateRevision);
  }
}
