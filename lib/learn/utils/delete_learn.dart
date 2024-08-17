import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';

abstract class DeleteLearnFactory {
  Future<Learn?> deleteLearnById(int id);
}

class DeleteLearn implements DeleteLearnFactory {
  LearnDatabaseFactory learnDatabase;

  DeleteLearn(this.learnDatabase);

  @override
  Future<Learn?> deleteLearnById(int id) async {
    return await learnDatabase.deleteLearnById(id);
  }
}
