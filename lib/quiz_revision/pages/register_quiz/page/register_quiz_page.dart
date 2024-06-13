import 'package:flutter/material.dart';
import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/utils/register_question/table_question.dart';

import 'package:planeje/utils/message_user.dart';
import 'package:planeje/widgets/bottom_sheet/bottom_sheet_widget.dart';

import '../../../../../widgets/text_button_widget.dart';
import '../../../../../widgets/text_form_field_widget.dart';
import '../../../utils/register_quiz/register_quiz.dart';
import '../component/table_question.dart';

class RegisterQuizPage extends StatelessWidget {
  RegisterQuizPage({super.key, required this.registerQuiz}) {
    description.text = registerQuiz.quiz.description ?? "";
    topic.text = registerQuiz.quiz.topic ?? "";
    _tableQuestionNotifier.initListQuestionEdit(registerQuiz.quiz.id);
  }

  final RegisterQuiz registerQuiz;
  final formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();
  final TextEditingController topic = TextEditingController();
  final TextEditingController label = TextEditingController();
  final TextEditingController question = TextEditingController();
  final TableQuestionNotifier _tableQuestionNotifier = TableQuestionNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          registerQuiz.message.getTypeQuiz?.name ?? '',
          style: const TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFieldWidget(
                  controller: topic,
                  onChange: registerQuiz.quiz.setTopic,
                  hintText: 'Assunto',
                  keyboardType: TextInputType.text,
                  textArea: false,
                  valid: false,
                ),
                TextFormFieldWidget(
                  controller: description,
                  onChange: registerQuiz.quiz.setDescription,
                  maxLine: 5,
                  hintText: 'Pergunta',
                  keyboardType: TextInputType.multiline,
                  textArea: true,
                ),
                TextFormFieldWidget(
                  controller: label,
                  hintText: 'Identificação',
                  keyboardType: TextInputType.text,
                  textArea: false,
                  valid: false,
                ),
                TextFormFieldWidget(
                  controller: question,
                  maxLine: 5,
                  hintText: 'Questão',
                  keyboardType: TextInputType.multiline,
                  textArea: true,
                  valid: false,
                ),
                TextButtonWidget(
                  label: 'Adicionar questão',
                  onClick: () {
                    _tableQuestionNotifier.addQuestion(Question(
                      label: label.text,
                      description: question.text,
                    ));
                    label.text = '';
                    question.text = '';
                  },
                ),
                ListenableBuilder(
                  listenable: _tableQuestionNotifier,
                  builder: (BuildContext context, Widget? child) {
                    return TableQuestion(
                      listQuestion: _tableQuestionNotifier.questions,
                      onClick: (index, value) => _tableQuestionNotifier.updateAnwser(index, value),
                      onDelete: (index) => _tableQuestionNotifier.deleteQuestion(index),
                    );
                  },
                ),
                const Padding(padding: EdgeInsets.all(40)),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: BottomSheetWidget(
        children: [
          TextButtonWidget.cancel(() => Navigator.pop(context, false)),
          TextButtonWidget.save(
            () async {
              try {
                if (!formKey.currentState!.validate()) return;

                if (!_tableQuestionNotifier.listQuestionuestionIsEmpty(context)) return;

                if (!_tableQuestionNotifier.isAnwserByListQuestion(context)) return;

                registerQuiz.quiz.setId(registerQuiz.quiz.id);
                registerQuiz.quiz.setTopic(topic.text);
                registerQuiz.quiz.setDescription(description.text);

                var result = await registerQuiz.writeQuiz();

                if (result != null) {
                  if (registerQuiz.quiz.id != null) result = registerQuiz.quiz.id;
                  await _tableQuestionNotifier.updateIdQuiz(result!);
                }

                if (context.mounted && result != null) {
                  MessageUser.message(context, registerQuiz.message.message);
                  Navigator.pop(context, true);
                }
              } catch (e) {
                if (context.mounted) MessageUser.message(context, 'Erro ao registrar!!!');
              }
            },
          ),
        ],
      ),
    );
  }
}
