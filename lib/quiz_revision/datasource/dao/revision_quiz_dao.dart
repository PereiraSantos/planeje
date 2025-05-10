import 'package:floor/floor.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';

@dao
abstract class RevisionQuizDao {
  @Query('SELECT * FROM revision_quiz')
  Future<List<RevisionQuiz>?> getAllRevisionQuiz();

  @Query('SELECT * FROM revision_quiz where sync = 0')
  Future<List<RevisionQuiz>?> findAllRevisionQuizSync();

  @insert
  Future<int> insertRevisionQuiz(RevisionQuiz revisionQuiz);

  @insert
  Future<void> insertRevisionQuizList(List<RevisionQuiz> revisionQuiz);

  @Query('SELECT * FROM revision_quiz WHERE id = :id')
  Future<RevisionQuiz?> getRevisionQuizById(int id);

  @Query('SELECT * FROM revision_quiz WHERE id_quiz = :idQuiz')
  Future<List<RevisionQuiz>?> getRevisionQuizByIdQuiz(int idQuiz);

  @Query('delete FROM revision_quiz WHERE id = :id')
  Future<RevisionQuiz?> deleteRevisionQuiz(int id);

  @Query('delete FROM revision_quiz WHERE id_quiz = :idQuiz')
  Future<void> deleteRevisionQuizByIdQuiz(int idQuiz);

  @Query('select count(*) from revision_quiz where id_external = :idExternal')
  Future<int?> isRegistration(int idExternal);

  @update
  Future<int> updateRevisionQuiz(RevisionQuiz revisionQuiz);

  @update
  Future<void> updateRevisionQuizList(List<RevisionQuiz> revisionQuiz);
}
