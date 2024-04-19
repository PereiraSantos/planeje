import 'package:floor/floor.dart';

import '../../../entities/question.dart';

@dao
abstract class QuestionDao {
  @Query('SELECT * FROM question')
  Future<List<Question>?> getAllQuestion();

  @insert
  Future<List<int>> insertQuestionList(List<Question> question);

  @insert
  Future<int> insertQuestion(Question question);

  @Query('SELECT * FROM question WHERE id = :id')
  Future<Question?> getQuestionById(int id);

  @Query('SELECT * FROM question WHERE id_quiz = :idQuiz')
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz);

  @Query('delete FROM question WHERE id = :id')
  Future<void> deleteQuestion(int id);

  @Query('delete FROM question WHERE id_quiz = :idQuiz')
  Future<void> deleteQuestionByIdQuiz(int idQuiz);

  @update
  Future<int> updateQuestion(Question question);
}
