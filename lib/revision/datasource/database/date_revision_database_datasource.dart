import 'package:planeje/revision/entities/date_revision.dart';

import '../../../database/app_database.dart';
import '../repository/datasource_date_revision_repository.dart';

class DateRevisionDatabaseDataSource implements DateRevisionDataSourceRepository {
  Future<AppDatabase> getInstance() async {
    return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  @override
  Future<DateRevision?> deleteDateRevisionById(int id) async {
    final database = await getInstance();
    return await database.dateRevisionDao.deleteDateRevisionById(id);
  }

  @override
  Future<List<DateRevision>> findAllDateRevisions() async {
    final database = await getInstance();
    return await database.dateRevisionDao.findAllRevisions();
  }

  @override
  Future<DateRevision?> findDateRevisionById(int id) async {
    final database = await getInstance();
    return await database.dateRevisionDao.findDateRevisionById(id);
  }

  @override
  Future<int> insertDateRevision(DateRevision dateRevision) async {
    final database = await getInstance();
    return await database.dateRevisionDao.insertDateRevision(dateRevision);
  }

  @override
  Future<int> updateDateRevision(DateRevision dateRevision) async {
    final database = await getInstance();
    return await database.dateRevisionDao.updateDateRevision(dateRevision);
  }
}
