import 'package:floor/floor.dart';
import 'package:planeje/quiz_revision/entities/question.dart';

@dao
abstract class QuestionDao {
  @Query('SELECT * FROM question')
  Future<List<Question>?> getAllQuestion();

  @Query('SELECT * FROM question where sync = 0')
  Future<List<Question>?> findAllQuestionSync();

  @insert
  Future<int> insertQuestion(Question question);

  @insert
  Future<List<int>> insertQuestionList(List<Question> question);

  @Query('SELECT * FROM question WHERE id = :id and disable = 0')
  Future<Question?> getQuestionById(int id);

  @Query('SELECT * FROM question WHERE id_quiz = :idQuiz and disable = 0')
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz);

  @Query('update question set disable = 1 WHERE id = :id')
  Future<void> disableQuestion(int id);

  @Query('update question set disable = 1 WHERE id_quiz = :idQuiz')
  Future<void> disableQuestionByIdQuiz(int idQuiz);

  @Query('select * from question where id_external  = :idExternal')
  Future<Question?> findQuestionByIdExternal(int idExternal);

  @update
  Future<int> updateQuestion(Question question);

  @update
  Future<void> updateQuestionList(List<Question> question);
}
