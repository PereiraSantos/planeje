import 'package:flutter/material.dart';
import 'package:planeje/revision/pages/register_revision/controller/revision_controller.dart';
import '../../../../usercase/format_date.dart';
import '../../../../widgets/text_button_widget.dart';
import '../../../../widgets/text_form_field_widget.dart';
import '../../../entities/revision.dart';
import '../component/change_date_next_review.dart';
import '../component/change_time_revision.dart';

// ignore: must_be_immutable
class RegisterRevision extends StatelessWidget {
  RegisterRevision({super.key, this.revisionEntity}) {
    textDescriptionController.text = revisionEntity?.description ?? '';
  }

  final Revision? revisionEntity;
  final RevisionRegisterController controller = RevisionRegisterController();
  final formKey = GlobalKey<FormState>();
  final TextEditingController textDescriptionController = TextEditingController();
  String? dateNextRevision;
  String? timeInit;
  String? timeEnd;

  String title() => revisionEntity != null ? "Atualizar" : "Adicionar";

  void message(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
          padding: const EdgeInsets.only(top: 0.0),
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
                ChangeTimeRevision(
                  onClickTimeInit: (time) => timeInit = time,
                  onClickTimeEnd: (time) => timeEnd = time,
                  revisionEntity: revisionEntity,
                ),
                ChangeDateNextReview(
                  revisionEntity: revisionEntity,
                  onClick: (value) => controller.setStatus(value),
                  onClickCalendar: (value) => dateNextRevision = value,
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
                if (!await controller.saveOrUpdate(
                    textDescriptionController.text,
                    dateNextRevision ??
                        revisionEntity?.nextDate ??
                        FormatDate().formatDate(FormatDate().newDate()),
                    timeInit,
                    timeEnd,
                    id: revisionEntity?.id)) {
                  return;
                }
                if (context.mounted) {
                  message(context,
                      revisionEntity?.id != null ? 'Atualizado com sucesso' : 'Registrado com sucesso');
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
