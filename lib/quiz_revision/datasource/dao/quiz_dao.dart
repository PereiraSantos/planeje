import 'package:floor/floor.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';

@dao
abstract class QuizDao {
  @Query('SELECT * FROM quiz')
  Future<List<Quiz>?> getAllQuiz();

  @Query('SELECT * FROM quiz where sync = 0')
  Future<List<Quiz>?> findAllQuizSync();

  @Query('SELECT * FROM quiz where topic LIKE :text')
  Future<List<Quiz>?> getAllQuizSearch(String text);

  @Query('select * from quiz where id_external = :idExternal')
  Future<Quiz?> findQuizByIdExternal(int idExternal);

  @insert
  Future<int> insertQuiz(Quiz quiz);

  @insert
  Future<List<int>> insertQuizList(List<Quiz> quiz);

  @Query('SELECT * FROM quiz WHERE id = :id')
  Future<Quiz?> getQuizById(int id);

  @Query('delete FROM quiz WHERE id = :id')
  Future<Quiz?> deleteQuiz(int id);

  @update
  Future<int> updateQuiz(Quiz quiz);

  @update
  Future<void> updateQuizList(List<Quiz> quiz);
}
