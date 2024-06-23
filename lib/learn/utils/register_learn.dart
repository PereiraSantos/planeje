import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/utils/type_message.dart';

abstract class RegsiterLearn {
  Future<int?> writeLearn();
  late Learn learn;
  late Message message;
}

class SaveLearn implements RegsiterLearn {
  DatasourceLearnRepository datasourceLearnRepository;
  SaveLearn(this.datasourceLearnRepository, this.learn, this.message);

  @override
  Future<int?> writeLearn() async {
    return await datasourceLearnRepository.insertLearn(learn);
  }

  @override
  Learn learn;

  @override
  Message message;
}

class UpdateLearn implements RegsiterLearn {
  DatasourceLearnRepository datasourceLearnRepository;
  UpdateLearn(this.datasourceLearnRepository, this.learn, this.message);

  @override
  Future<int?> writeLearn() async {
    return await datasourceLearnRepository.updateLearn(learn);
  }

  @override
  Learn learn;

  @override
  Message message;
}
