import 'package:planeje/database/app_database.dart';
import 'package:planeje/learn/entities/learn.dart';

abstract class DatasourceLearnRepository {
  Future<List<Learn>?> getAllLearn(String text);
  Future<int> insertLearn(Learn learn);
  Future<Learn?> getLearnId(int id);
  Future<int> updateLearn(Learn learn);
  Future<Learn?> deleteLearnById(int id);
}

class LearnDatabase implements DatasourceLearnRepository {
  @override
  Future<List<Learn>?> getAllLearn(String text) async {
    final database = await getInstance();
    if (text != '') return await database.learnDao.getLearn('%$text%');
    return await database.learnDao.getAllLearn();
  }

  @override
  Future<Learn?> getLearnId(int id) async {
    final database = await getInstance();
    return await database.learnDao.getLearnId(id);
  }

  @override
  Future<int> insertLearn(Learn learn) async {
    final database = await getInstance();
    return await database.learnDao.insertLearn(learn);
  }

  @override
  Future<int> updateLearn(Learn learn) async {
    final database = await getInstance();
    return await database.learnDao.updateLearn(learn);
  }

  @override
  Future<Learn?> deleteLearnById(int id) async {
    final database = await getInstance();
    return await database.learnDao.deleteLearnById(id);
  }
}
