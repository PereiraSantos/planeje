import 'package:flutter/material.dart';
import 'package:planeje/revision/pages/regsiter_revision/controller/revision_controller.dart';

import '../../../../entities/revision.dart';
import '../../../../widgets/text_button_widget.dart';
import '../../../../widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class RegisterRevision extends StatelessWidget {
  RegisterRevision({Key? key, this.revisionEntity}) : super(key: key);

  final Revision? revisionEntity;
  final RevisionRegisterController controller = RevisionRegisterController();
  final formKey = GlobalKey<FormState>();
  final TextEditingController textDescriptionController = TextEditingController();
  TimeOfDay? selectedTime;

  String title() => revisionEntity != null ? "Atualizar" : "Adicionar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          title(),
          style: const TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFieldWidget(
                  controller: textDescriptionController,
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
                if (!await controller.saveOrUpdate(textDescriptionController.text, id: revisionEntity?.id)) {
                  return;
                }
                if (context.mounted) Navigator.pop(context, true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
