import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/repository/question_repository.dart';

import '../../datasource/repository/datasource_question_repository.dart';

class QuestionUsercase implements QuestionRepository {
  final DatasourceQuestionRepository _datasourceQuestionRepository;

  QuestionUsercase(this._datasourceQuestionRepository);

  @override
  Future<void> deleteQuestion(int id) async {
    return await _datasourceQuestionRepository.deleteQuestion(id);
  }

  @override
  Future<List<Question>?> getAllQuestion() async {
    return await _datasourceQuestionRepository.getAllQuestion();
  }

  @override
  Future<Question?> getQuestionById(int id) async {
    return await _datasourceQuestionRepository.getQuestionById(id);
  }

  @override
  Future<List<int>> insertQuestionList(List<Question> question) async {
    return await _datasourceQuestionRepository.insertQuestionList(question);
  }

  @override
  Future<int> updateQuestion(Question question) async {
    return await _datasourceQuestionRepository.updateQuestion(question);
  }

  @override
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz) async {
    return await _datasourceQuestionRepository.getQuestionByIdQuiz(idQuiz);
  }

  @override
  Future<int> insertQuestion(Question question) async {
    return await _datasourceQuestionRepository.insertQuestion(question);
  }

  @override
  Future<void> deleteQuestionByIdQuiz(int idQuiz) async {
    return await _datasourceQuestionRepository.deleteQuestionByIdQuiz(idQuiz);
  }
}
