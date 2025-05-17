import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/utils/register_question/register_question.dart';
import 'package:planeje/sync/list_info.dart';

class QuestionController {
  List<ListInfo> questionInfos = [];

  Future<bool> writeQuestion() async {
    List<ListInfo> listInfoUpdate = [...questionInfos.where((item) => item.update)];

    questionInfos.removeWhere((item) => item.update);

    if (listInfoUpdate.isNotEmpty) {
      await UpdateQuestion(QuestionDatabase(), questions: listInfoUpdate.map<Question>((e) => e.lists).toList()).writeQuestionList();
    }

    if (questionInfos.isNotEmpty) {
      await SaveQuestion(QuestionDatabase(), questions: questionInfos.map<Question>((e) => e.lists).toList()).writeQuestionList();
    }

    return true;
  }

  Future<Question?> findQuestionByIdExternal(int idExternal) async {
    return await GetQuestion(QuestionDatabase()).findQuestionByIdExternal(idExternal);
  }
}
