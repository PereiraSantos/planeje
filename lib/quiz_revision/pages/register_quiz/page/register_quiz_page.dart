import 'package:flutter/material.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';

import '../../../../../widgets/text_button_widget.dart';
import '../../../../../widgets/text_form_field_widget.dart';
import '../component/table_question.dart';
import '../controller/quiz_controller.dart';

class RegisterQuizPage extends StatelessWidget {
  RegisterQuizPage({super.key, this.quizEntity}) {
    description.text = quizEntity?.description ?? "";
    topic.text = quizEntity?.topic ?? "";

    controller.quiz.setDescription(quizEntity?.description);
    controller.quiz.setTopic(quizEntity?.topic);

    if (quizEntity?.id != null) {
      controller.quiz.setId(quizEntity!.id!);

      controller.getQuestionByIdQuiz();
    }
  }

  final Quiz? quizEntity;
  final QuizController controller = QuizController();
  final formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();
  final TextEditingController topic = TextEditingController();
  final TextEditingController label = TextEditingController();
  final TextEditingController question = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          quizEntity != null ? "Atualizar" : "Adicionar",
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
                  onChange: controller.quiz.setTopic,
                  hintText: 'Assunto',
                  keyboardType: TextInputType.text,
                  textArea: false,
                  valid: false,
                ),
                TextFormFieldWidget(
                  controller: description,
                  onChange: controller.quiz.setDescription,
                  maxLine: 5,
                  hintText: 'Pergunta',
                  keyboardType: TextInputType.multiline,
                  textArea: true,
                ),
                TextFormFieldWidget(
                  controller: label,
                  onChange: controller.question.setLabel,
                  hintText: 'Identificação',
                  keyboardType: TextInputType.text,
                  textArea: false,
                  valid: false,
                ),
                TextFormFieldWidget(
                  controller: question,
                  onChange: controller.question.setDescription,
                  maxLine: 5,
                  hintText: 'Questão',
                  keyboardType: TextInputType.multiline,
                  textArea: true,
                  valid: false,
                ),
                TextButtonWidget(
                  label: 'Adicionar questão',
                  onClick: () {
                    controller.setListQuestion();
                    label.text = '';
                    question.text = '';
                  },
                ),
                ListenableBuilder(
                  listenable: controller.tableQuestionController,
                  builder: (BuildContext context, Widget? child) {
                    return TableQuestion(
                      listQuestion: controller.tableQuestionController.listQuestion,
                      onClick: (index, value) =>
                          controller.tableQuestionController.updateAnwser(index, value),
                    );
                  },
                ),
                const Padding(padding: EdgeInsets.all(40)),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: const Color(0xffffffff),
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButtonWidget(label: 'CANCELA', onClick: () => Navigator.pop(context, false)),
            TextButtonWidget(
              label: 'SALVAR',
              onClick: () async {
                try {
                  if (!formKey.currentState!.validate()) return;

                  if (controller.tableQuestionController.listQuestion.isEmpty) {
                    controller.message(context, 'Obrigatório adicionar registro');
                    return;
                  }

                  if (!controller.tableQuestionController.isAnwser()) {
                    controller.message(context, 'Obrigatório marcar uma resposta');
                    return;
                  }

                  var result = quizEntity?.id == null
                      ? await controller.registerQuiz()
                      : await controller.updateQuiz();

                  if (context.mounted && result != null) {
                    controller.message(context,
                        quizEntity?.id != null ? 'Atualizado com sucesso' : 'Registrado com sucesso');
                    Navigator.pop(context, true);
                  }
                } catch (e) {
                  controller.message(context, 'Erro ao registrar!!!');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
