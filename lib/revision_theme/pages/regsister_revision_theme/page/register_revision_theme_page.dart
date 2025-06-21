import 'package:flutter/material.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/utils/insert_revision_theme.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:planeje/widgets/text_button_widget.dart';
import 'package:planeje/widgets/text_form_field_widget.dart';

class RegisterRevisionThemePage extends StatelessWidget {
  RegisterRevisionThemePage({super.key, required this.register, required this.statusNotification, this.revisionTheme}) {
    description.text = revisionTheme?.description ?? '';
  }

  final RevisionThemeFactory register;
  final formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();
  final StatusNotification statusNotification;
  final RevisionTheme? revisionTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          statusNotification.getTypeQuiz!.name,
          style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormFieldWidget(
                  controller: description,
                  maxLine: 5,
                  hintText: 'Tema',
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

                revisionTheme?.setId(revisionTheme?.id);
                revisionTheme?.setDescription(description.text);
                revisionTheme?.setSync();

                if (revisionTheme?.id == null) revisionTheme?.setInsertApp(true);

                register.revisionTheme = revisionTheme!;
                var idRevision = await register.write();

                if (idRevision == null) return;

                if (context.mounted) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await MessageUser.message(context, statusNotification.message);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
                }
              } catch (e) {
                if (context.mounted) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await MessageUser.message(context, 'Erro ao registrar!!!, $e');
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
