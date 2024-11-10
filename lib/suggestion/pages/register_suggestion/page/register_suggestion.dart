import 'package:flutter/material.dart';
import 'package:planeje/revision/pages/register_revision/component/drop_down_button_custom_revision.dart';
import 'package:planeje/suggestion/utils/register_suggestion.dart';

import 'package:planeje/widgets/bottom_sheet/bottom_sheet_widget.dart';
import '../../../../utils/message_user.dart';
import '../../../../widgets/text_button_widget.dart';
import '../../../../widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class RegisterSuggestion extends StatelessWidget {
  RegisterSuggestion({super.key, required this.registerSuggestion}) {
    description.text = registerSuggestion.suggestion.description ?? '';
  }

  SuggestionFactory registerSuggestion;
  final formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          registerSuggestion.message.getTypeQuiz!.name,
          style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
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
                DropDownButtonCustomRevision(
                  onClick: (value) => registerSuggestion.suggestion.setIdLearn(value),
                  idLearn: registerSuggestion.suggestion.idLearn,
                ),
                TextFormFieldWidget(
                  controller: description,
                  maxLine: 5,
                  hintText: 'Descrição',
                  keyboardType: TextInputType.multiline,
                  textArea: true,
                ),
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

                registerSuggestion.suggestion.setDescription(description.text);

                var result = await registerSuggestion.write();

                if (result != null && context.mounted) {
                  MessageUser.message(context, registerSuggestion.message.message);
                  Navigator.pop(context, true);
                }
              } catch (e) {
                if (!context.mounted) return;
                MessageUser.message(context, 'Erro ao registrar!!!');
              }
            },
          ),
        ],
      ),
    );
  }
}
