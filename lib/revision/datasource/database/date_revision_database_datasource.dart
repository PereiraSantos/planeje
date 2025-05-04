import 'package:planeje/revision/datasource/dao/find_date_revision.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';

import '../../../database/app_database.dart';

abstract class DateRevisionDatabaseFactory {
  Future<List<DateRevision>> findAllDateRevisions();
  Future<DateRevision?> findDateRevisionById(int id);
  Future<DateRevision?> deleteDateRevisionById(int id);
  Future<void> deleteDateRevisionByIdRevision(int idRevision);
  Future<int?> insertDateRevision(DateRevision dateRevision);
  Future<List<int>> insertDateRevisionList(List<DateRevision> dateRevisions);
  Future<int?> updateDateRevision(DateRevision dateRevision);
  Future<void> updateHourInit(String hourInit, int id);
  Future<void> updateHourEnd(String hourEnd, String dateRevision, String nextDateRevision, int id);
  Future<List<RevisionTime>?> findDateRevisionByIdDate(int id);
  Future<void> updateStatus(bool status, int id);
  Future<List<DateRevision>?> findAllDateRevisionSync();
  Future<void> updateDateRevisionList(List<DateRevision> dateRevision);
  Future<int?> isRegistration(int id);
}

class DateRevisionDatabaseDataSource implements DateRevisionDatabaseFactory {
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
  Future<int?> insertDateRevision(DateRevision dateRevision) async {
    final database = await getInstance();
    return await database.dateRevisionDao.insertDateRevision(dateRevision);
  }

  @override
  Future<int?> updateDateRevision(DateRevision dateRevision) async {
    final database = await getInstance();
    return await database.dateRevisionDao.updateDateRevision(dateRevision);
  }

  @override
  Future<void> updateHourEnd(String hourEnd, String dateRevision, String nextDateRevision, int id) async {
    final database = await getInstance();
    await database.dateRevisionDao.updateHourEndRevision(hourEnd, dateRevision, nextDateRevision, id);
  }

  @override
  Future<void> updateHourInit(String hourInit, int id) async {
    final database = await getInstance();
    await database.dateRevisionDao.updateHourInitRevision(hourInit, id);
  }

  @override
  Future<List<RevisionTime>?> findDateRevisionByIdDate(int id) async {
    final database = await getInstance();
    return await FindDateRevisionDao().findDateRevisionById(database, id);
  }

  @override
  Future<void> updateStatus(bool status, int id) async {
    final database = await getInstance();
    await database.dateRevisionDao.updateStatus(status, id);
  }

  @override
  Future<void> deleteDateRevisionByIdRevision(int idRevision) async {
    final database = await getInstance();
    await database.dateRevisionDao.deleteDateRevisionByIdRevision(idRevision);
  }

  @override
  Future<List<int>> insertDateRevisionList(List<DateRevision> dateRevisions) async {
    final database = await getInstance();
    return await database.dateRevisionDao.insertDateRevisionList(dateRevisions);
  }

  @override
  Future<List<DateRevision>?> findAllDateRevisionSync() async {
    final database = await getInstance();
    return await database.dateRevisionDao.findAllDateRevisionSync();
  }

  @override
  Future<void> updateDateRevisionList(List<DateRevision> dateRevision) async {
    final database = await getInstance();
    return await database.dateRevisionDao.updateDateRevisionList(dateRevision);
  }

  @override
  Future<int?> isRegistration(int id) async {
    final database = await getInstance();
    return await database.dateRevisionDao.isRegistration(id);
  }
}
