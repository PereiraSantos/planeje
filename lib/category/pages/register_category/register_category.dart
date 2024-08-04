import 'package:flutter/material.dart';
import 'package:planeje/category/utils/register_category.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:planeje/widgets/text_button_widget.dart';
import 'package:planeje/widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class RegisterCategoryPage extends StatelessWidget {
  RegisterCategoryPage({super.key, required this.registerCategory}) {
    description.text = registerCategory.category.description ?? '';
  }

  RegisterCategory registerCategory;
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
          registerCategory.message.getTypeQuiz!.name,
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
                TextFormFieldWidget(
                  controller: description,
                  onChange: registerCategory.category.setDescription,
                  hintText: 'Descrição',
                  keyboardType: TextInputType.text,
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

                registerCategory.category.setDescription(description.text);

                var result = await registerCategory.writeCategory();

                if (context.mounted && result != null) {
                  MessageUser.message(context, registerCategory.message.message);
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
