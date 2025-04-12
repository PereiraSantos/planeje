import 'package:floor/floor.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';

@dao
abstract class RevisionQuizDao {
  @Query('SELECT * FROM revision_quiz')
  Future<List<RevisionQuiz>?> getAllRevisionQuiz();

  @insert
  Future<int> insertRevisionQuiz(RevisionQuiz revisionQuiz);

  @Query('SELECT * FROM revision_quiz WHERE id = :id')
  Future<RevisionQuiz?> getRevisionQuizById(int id);

  @Query('SELECT * FROM revision_quiz WHERE id_quiz = :idQuiz')
  Future<List<RevisionQuiz>?> getRevisionQuizByIdQuiz(int idQuiz);

  @Query('delete FROM revision_quiz WHERE id = :id')
  Future<RevisionQuiz?> deleteRevisionQuiz(int id);

  @Query('delete FROM revision_quiz WHERE id_quiz = :idQuiz')
  Future<void> deleteRevisionQuizByIdQuiz(int idQuiz);

  @update
  Future<int> updateRevisionQuiz(RevisionQuiz revisionQuiz);
}
