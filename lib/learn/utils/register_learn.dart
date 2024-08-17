import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/utils/type_message.dart';

abstract class RegisterLearnFactory {
  Future<int?> writeLearn();
  late Learn learn;
  late Message message;
}

class SaveLearn implements RegisterLearnFactory {
  LearnDatabaseFactory learnDatabase;
  SaveLearn(this.learnDatabase, this.learn, this.message);

  @override
  Future<int?> writeLearn() async {
    return await learnDatabase.insertLearn(learn);
  }

  @override
  Learn learn;

  @override
  Message message;
}

class UpdateLearn implements RegisterLearnFactory {
  LearnDatabaseFactory learnDatabase;
  UpdateLearn(this.learnDatabase, this.learn, this.message);

  @override
  Future<int?> writeLearn() async {
    return await learnDatabase.updateLearn(learn);
  }

  @override
  Learn learn;

  @override
  Message message;
}
