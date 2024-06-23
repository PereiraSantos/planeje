import 'package:planeje/quiz_revision/entities/quiz.dart';

import '../../../database/app_database.dart';

abstract class DatasourceQuizRepository {
  Future<List<Quiz>?> getAllQuiz(String text);
  Future<int> insertQuiz(Quiz quiz);
  Future<Quiz?> getQuizById(int id);
  Future<Quiz?> deleteQuiz(int id);
  Future<int> updateQuiz(Quiz quiz);
}

class QuizDatabase implements DatasourceQuizRepository {
  Future<AppDatabase> getInstance() async {
    return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  @override
  Future<Quiz?> deleteQuiz(int id) async {
    final database = await getInstance();
    return await database.quizDao.deleteQuiz(id);
  }

  @override
  Future<List<Quiz>?> getAllQuiz(String text) async {
    final database = await getInstance();
    return text != ''
        ? await database.quizDao.getAllQuizSearch('%$text%')
        : await database.quizDao.getAllQuiz();
  }

  @override
  Future<Quiz?> getQuizById(int id) async {
    final database = await getInstance();
    return await database.quizDao.getQuizById(id);
  }

  @override
  Future<int> insertQuiz(Quiz quiz) async {
    final database = await getInstance();
    return await database.quizDao.insertQuiz(quiz);
  }

  @override
  Future<int> updateQuiz(Quiz quiz) async {
    final database = await getInstance();
    return await database.quizDao.updateQuiz(quiz);
  }
}
