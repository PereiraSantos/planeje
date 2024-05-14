import 'package:flutter/material.dart';
import 'package:planeje/quiz_revision/pages/register_quiz/controller/table_question_controller.dart';

import '../../../datasource/database/question_database.dart';
import '../../../datasource/database/quiz_database.dart';
import '../../../entities/question.dart';
import '../../../entities/quiz.dart';
import '../../../usercase/question_usercase/question_usercase.dart';
import '../../../usercase/quiz_usercase/quiz_usercase.dart';

class QuizController {
  Question question = Question();
  Quiz quiz = Quiz();
  QuestionUsercase questionUsercase = QuestionUsercase(QuestionDatabase());
  QuizUsercase quizUsercase = QuizUsercase(QuizDatabase());

  TableQuestionController tableQuestionController = TableQuestionController();

  void message(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void setListQuestion() {
    if (question.description != "" && question.description != null) {
      tableQuestionController.update(
        Question(description: question.description, label: question.label, answer: false),
      );
    }
  }

  Future<int?> registerQuiz() async {
    var idQuiz = await quizUsercase.insertQuiz(quiz);
    tableQuestionController.updateIdQuiz(idQuiz);
    return await registerQuestion();
  }

  Future<int> registerQuestion() async {
    var result = await questionUsercase.insertQuestionList(tableQuestionController.listQuestion);
    if (result.length == tableQuestionController.listQuestion.length) return 1;
    return -1;
  }

  Future<int?> updateQuiz() async {
    await quizUsercase.updateQuiz(quiz);
    tableQuestionController.updateIdQuiz(quiz.id!);
    return await updateQuestion();
  }

  Future<int> updateQuestion() async {
    for (var element in tableQuestionController.listQuestion) {
      element.id != null
          ? await questionUsercase.updateQuestion(element)
          : await questionUsercase.insertQuestion(element);
    }

    for (var element in tableQuestionController.listQuestions) {
      questionUsercase.deleteQuestion(element.id!);
    }

    return Future.value(1);
  }

  Future<void> getQuestionByIdQuiz() async {
    List<Question>? list = await questionUsercase.getQuestionByIdQuiz(quiz.id!);
    tableQuestionController.updateList(list ?? []);
  }
}
