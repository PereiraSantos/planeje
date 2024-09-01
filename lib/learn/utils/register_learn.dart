import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/utils/register.dart';
import 'package:planeje/utils/type_message.dart';

abstract class RegisterLearnFactory extends RegisterFactory {
  late Learn learn;
}

class SaveLearn implements RegisterLearnFactory {
  LearnDatabaseFactory learnDatabase;
  SaveLearn(this.learnDatabase, this.learn, this.message);

  @override
  Future<int?> write() async {
    return await learnDatabase.insertLearn(learn);
  }

  @override
  Learn learn;

  @override
  StatusNotification message;
}

class UpdateLearn implements RegisterLearnFactory {
  LearnDatabaseFactory learnDatabase;
  UpdateLearn(this.learnDatabase, this.learn, this.message);

  @override
  Future<int?> write() async {
    return await learnDatabase.updateLearn(learn);
  }

  @override
  Learn learn;

  @override
  StatusNotification message;
}
