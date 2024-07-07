import 'package:flutter/material.dart';
import 'package:planeje/widgets/button_custon.dart';
import '../../../../widgets/checkbox_custom.dart';
import '../../../entities/question.dart';
import '../controller/list_question_controller.dart';

// ignore: must_be_immutable
class ListQuestion extends StatefulWidget {
  const ListQuestion({
    super.key,
    required this.listQuestion,
  });

  final List<Question> listQuestion;

  @override
  State<ListQuestion> createState() => _ListQuestionState();
}

class _ListQuestionState extends State<ListQuestion> {
  ListQuestionController listQuestionController = ListQuestionController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          itemCount: widget.listQuestion.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 08, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: CheckBoxCustom(
                      isChecked: listQuestionController.getCheck(widget.listQuestion, index),
                      onClick: (value) {
                        listQuestionController.updateAnswer(index, value, widget.listQuestion);
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        '${widget.listQuestion[index].description}',
                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 05, top: 10, bottom: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (listQuestionController.index == -1) return;
                  listQuestionController.showAnswer = true;
                  setState(() {});
                },
                child: ButtonCuston(
                  color: const Color.fromARGB(171, 209, 208, 208),
                  width: MediaQuery.of(context).size.width * 0.2,
                  margin: const EdgeInsets.only(left: 05),
                  child: const Text(
                    "Verificar",
                    style: TextStyle(
                        fontSize: 13, color: Color.fromARGB(137, 10, 5, 5), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Visibility(
                  visible: listQuestionController.isAnswer(widget.listQuestion, true),
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Visibility(
                  visible: listQuestionController.isAnswer(widget.listQuestion, false),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
