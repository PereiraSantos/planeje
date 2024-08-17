import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';

abstract class FindLearnFactory {
  Future<List<Learn>?> getAllLearn(String text);
  Future<Learn?> getLearnId(int id);
}

class GetLearn implements FindLearnFactory {
  LearnDatabaseFactory learnDatabase;

  GetLearn(this.learnDatabase);

  @override
  Future<List<Learn>?> getAllLearn(String text) async {
    return await learnDatabase.getAllLearn(text);
  }

  @override
  Future<Learn?> getLearnId(int id) async {
    return await learnDatabase.getLearnId(id);
  }
}
