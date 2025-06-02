import 'package:dio/dio.dart';

import 'package:planeje/quiz_revision/datasource/database/revision_quiz_database.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';
import 'package:planeje/quiz_revision/utils/revision_quiz/register_revision_quiz.dart';
import 'package:planeje/quiz_revision/utils/revision_quiz/revision_quiz.dart';
import 'package:planeje/sync/revision_quiz/revision_quiz_controller.dart';

import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';

class RevisionQuizSync {
  Future<bool> getRevisionQuiz() async {
    Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.quiz]).get();

    RevisionQuizController revisionQuizController = RevisionQuizController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        RevisionQuiz revisionQuiz = RevisionQuiz.fromMapToObject(item);

        revisionQuizController.revisionQuizs.add(revisionQuiz);
      }
      await revisionQuizController.deteleTable();

      await revisionQuizController.writeRevisionQuiz();
    }
    return true;
  }

  Future<bool> postRevisionQuiz() async {
    List<RevisionQuiz> lists = await GetRevisionQuiz(RevisionQuizDatabase()).findAllRevisionQuizSync() ?? [];

    if (lists.isNotEmpty) {
      for (RevisionQuiz item in lists) {
        if (item.insertApp!) item.id = null;

        Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.quiz]).post(RevisionQuiz.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = true;

          await UpdateRevisionQuiz(RevisionQuizDatabase(), revisionQuiz: item).writeRevisionQuiz();
        }
      }
    }
    return true;
  }

  Future<bool> postRevisionQuizDisable() async {
    List<RevisionQuiz> lists = await GetRevisionQuiz(RevisionQuizDatabase()).findRevisionQuizDisable() ?? [];

    if (lists.isNotEmpty) {
      for (RevisionQuiz item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.quiz, Endpoint.update]).post(RevisionQuiz.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = true;

          await UpdateRevisionQuiz(RevisionQuizDatabase(), revisionQuiz: item).writeRevisionQuiz();
        }
      }
    }
    return true;
  }
}
