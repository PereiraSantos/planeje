import 'package:dio/dio.dart';
import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/utils/register_question/register_question.dart';
import 'package:planeje/sync/list_info.dart';
import 'package:planeje/sync/question/question_controller.dart';
import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';

class QuestionSync {
  Future<bool> getQuestion() async {
    Response response = await Network(ConfigApi(), [Endpoint.question]).get();

    QuestionController questionController = QuestionController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        Question question = Question.fromMapToObject(item);

        Question? questionDatabase = await questionController.findQuestionByIdExternal(question.idExternal!);

        if (questionDatabase != null) question.id = questionDatabase.id;

        questionController.annotationInfos.add(ListInfo(lists: question, update: (question.id != null)));
      }

      await questionController.writeRevision();
    }
    return true;
  }

  Future<bool> postQuestion() async {
    List<Question> lists = await GetQuestion(QuestionDatabase()).findAllQuestionSync() ?? [];

    if (lists.isNotEmpty) {
      for (Question item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.question]).post(Question.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = true;

          await QuestionDatabase().updateQuestion(item);
        }
      }
    }
    return true;
  }
}
