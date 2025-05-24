import 'package:planeje/quiz_revision/entities/quiz.dart';

import '../../../database/app_database.dart';

abstract class QuizDatabaseFactory {
  Future<List<Quiz>?> getAllQuiz(String text);
  Future<int> insertQuiz(Quiz quiz);
  Future<List<int>> insertQuizList(List<Quiz> quizs);
  Future<Quiz?> getQuizById(int id);
  Future<Quiz?> disableQuiz(int id);
  Future<int> updateQuiz(Quiz quiz);
  Future<List<Quiz>?> findAllQuizSync();
  Future<void> updateQuizList(List<Quiz> quiz);
  Future<Quiz?> findQuizByIdExternal(int idExternal);
}

class QuizDatabase implements QuizDatabaseFactory {
  @override
  Future<Quiz?> disableQuiz(int id) async {
    final database = await getInstance();
    return await database.quizDao.disableQuiz(id);
  }

  @override
  Future<List<Quiz>?> getAllQuiz(String text) async {
    final database = await getInstance();
    return text != '' ? await database.quizDao.getAllQuizSearch('%$text%') : await database.quizDao.getAllQuiz();
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

  @override
  Future<List<int>> insertQuizList(List<Quiz> quizs) async {
    final database = await getInstance();
    return await database.quizDao.insertQuizList(quizs);
  }

  @override
  Future<List<Quiz>?> findAllQuizSync() async {
    final database = await getInstance();
    return await database.quizDao.findAllQuizSync();
  }

  @override
  Future<void> updateQuizList(List<Quiz> quiz) async {
    final database = await getInstance();
    return await database.quizDao.updateQuizList(quiz);
  }

  @override
  Future<Quiz?> findQuizByIdExternal(int idExternal) async {
    final database = await getInstance();
    return await database.quizDao.findQuizByIdExternal(idExternal);
  }
}
