import 'package:floor/floor.dart';

import '../../../entities/quiz.dart';

@dao
abstract class QuizDao {
  @Query('SELECT * FROM quiz')
  Future<List<Quiz>?> getAllQuiz();

  @insert
  Future<int> insertQuiz(Quiz quiz);

  @Query('SELECT * FROM quiz WHERE id = :id')
  Future<Quiz?> getQuizById(int id);

  @Query('delete FROM quiz WHERE id = :id')
  Future<Quiz?> deleteQuiz(int id);

  @update
  Future<int> updateQuiz(Quiz quiz);
}
