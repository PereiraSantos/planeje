import 'package:floor/floor.dart';
import 'package:planeje/learn/entities/learn.dart';

@dao
abstract class LearnDao {
  @Query('SELECT * FROM learn')
  Future<List<Learn>?> getAllLearn();

  @Query('SELECT * FROM learn where description LIKE :text')
  Future<List<Learn>?> getLearn(String text);

  @insert
  Future<int> insertLearn(Learn learn);

  @Query('SELECT * FROM learn WHERE id = :id')
  Future<Learn?> getLearnId(int id);

  @Query('delete FROM learn WHERE id = :id')
  Future<Learn?> deleteLearnById(int id);

  @update
  Future<int> updateLearn(Learn learn);
}
