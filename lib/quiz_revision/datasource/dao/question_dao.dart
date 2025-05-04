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

  @Query('SELECT * FROM question WHERE id = :id')
  Future<Question?> getQuestionById(int id);

  @Query('SELECT * FROM question WHERE id_quiz = :idQuiz')
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz);

  @Query('delete FROM question WHERE id = :id')
  Future<void> deleteQuestion(int id);

  @Query('delete FROM question WHERE id_quiz = :idQuiz')
  Future<void> deleteQuestionByIdQuiz(int idQuiz);

  @Query('select count(*) from question where id  = :id')
  Future<int?> isRegistration(int id);

  @update
  Future<int> updateQuestion(Question question);

  @update
  Future<void> updateQuestionList(List<Question> question);
}
