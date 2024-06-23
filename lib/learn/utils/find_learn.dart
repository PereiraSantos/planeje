import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';

abstract class IFindLearn {
  Future<List<Learn>?> getAllLearn(String text);
  Future<Learn?> getLearnId(int id);
}

class GetLearn implements IFindLearn {
  DatasourceLearnRepository datasourceLearnRepository;

  GetLearn(this.datasourceLearnRepository);

  @override
  Future<List<Learn>?> getAllLearn(String text) async {
    return await datasourceLearnRepository.getAllLearn(text);
  }

  @override
  Future<Learn?> getLearnId(int id) async {
    return await datasourceLearnRepository.getLearnId(id);
  }
}
