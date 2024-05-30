import 'package:flutter/material.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/utils/message_user.dart';

import '../../../../widgets/text_button_widget.dart';
import '../component/drop_down_revision.dart';

// ignore: must_be_immutable
class RegisterAnnotation extends StatelessWidget {
  RegisterAnnotation({super.key, required this.registerAnnotation}) {
    textController.text = registerAnnotation.annotation.text ?? '';
  }

  IRegisterAnnotation registerAnnotation;
  final formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          registerAnnotation.message.getTypeQuiz!.name,
          style: const TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DropDownButtonCustom(
                onClick: (value) => registerAnnotation.annotation.setIdRevision(value),
                idRevision: registerAnnotation.annotation.idRevision,
              ),
              const Text(
                "Descrição",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Flexible(
                child: TextFormField(
                  controller: textController,
                  maxLines: 40,
                  style: const TextStyle(fontSize: 22, color: Colors.black54),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 1.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12, width: 1.0),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 22.0,
                      fontFamily: 'helvetica_neue_light',
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
              ),
            ],
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
                if (!formKey.currentState!.validate()) return;

                registerAnnotation.annotation.setId(registerAnnotation.annotation.id);
                registerAnnotation.annotation.setText(textController.text);
                registerAnnotation.annotation.setDateText(registerAnnotation.annotation.dateText);

                await registerAnnotation.writeAnnotation();

                if (context.mounted) {
                  MessageUser.message(context, registerAnnotation.message.message);
                  Navigator.pop(context, true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
