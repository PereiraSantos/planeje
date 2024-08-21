import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/utils/find.dart';

abstract class FindLearnFactory extends FindFactory {}

class GetLearn implements FindLearnFactory {
  LearnDatabaseFactory learnDatabase;

  GetLearn(this.learnDatabase);

  @override
  Future<List<Learn>?> getAll(String text) async {
    return await learnDatabase.getAllLearn(text);
  }

  @override
  Future<Learn?> getById(int id) async {
    return await learnDatabase.getLearnId(id);
  }
}
