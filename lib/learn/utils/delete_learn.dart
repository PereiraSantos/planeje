import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/utils/delete.dart';

abstract class DeleteLearnFactory extends DeleteFactory {}

class DeleteLearn implements DeleteLearnFactory {
  LearnDatabaseFactory learnDatabase;

  DeleteLearn(this.learnDatabase);

  @override
  Future<Learn?> deleteById(int id) async {
    return await learnDatabase.deleteLearnById(id);
  }
}
