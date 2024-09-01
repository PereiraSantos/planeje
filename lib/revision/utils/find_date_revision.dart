import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';

abstract class FindDateRevisionFactory {
  Future<List<RevisionTime>?> findDateRevisionByIdDate(int id);
  Future<DateRevision?> findDateRevisionById(int id);
}

class FindDateRevision implements FindDateRevisionFactory {
  DateRevisionDataSourceRepository dataSourceRepository;

  FindDateRevision(this.dataSourceRepository);
  @override
  Future<List<RevisionTime>?> findDateRevisionByIdDate(int id) async {
    return await dataSourceRepository.findDateRevisionByIdDate(id);
  }

  @override
  Future<DateRevision?> findDateRevisionById(int id) async {
    return await dataSourceRepository.findDateRevisionById(id);
  }
}
