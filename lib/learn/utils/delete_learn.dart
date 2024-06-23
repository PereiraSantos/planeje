import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';

abstract class IDeleteLearn {
  Future<Learn?> deleteLearnById(int id);
}

class DeleteLearn implements IDeleteLearn {
  DatasourceLearnRepository datasourceLearnRepository;

  DeleteLearn(this.datasourceLearnRepository);

  @override
  Future<Learn?> deleteLearnById(int id) async {
    return await datasourceLearnRepository.deleteLearnById(id);
  }
}
