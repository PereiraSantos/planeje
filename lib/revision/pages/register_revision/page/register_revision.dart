import 'package:flutter/material.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/pages/register_revision/controller/revision_controller.dart';
import 'package:planeje/utils/format_date.dart';
import '../../../../widgets/text_button_widget.dart';
import '../../../../widgets/text_form_field_widget.dart';
import '../component/change_date_next_review.dart';
import '../component/change_time_revision.dart';

// ignore: must_be_immutable
class RegisterRevision extends StatelessWidget {
  RegisterRevision({super.key, this.revisionEntity}) {
    description.text = revisionEntity?.revision.description ?? '';
  }

  final RevisionTime? revisionEntity;
  final RevisionRegisterController controller = RevisionRegisterController();
  final formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();
  String? dateNextRevision;
  String? timeInit;
  String? timeEnd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          revisionEntity != null ? "Atualizar" : "Adicionar",
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
                  controller: description,
                  maxLine: 5,
                  hintText: 'Descrição',
                  keyboardType: TextInputType.multiline,
                  textArea: true,
                ),
                ChangeTimeRevision(
                  onClickTimeInit: (time) => timeInit = time,
                  onClickTimeEnd: (time) => timeEnd = time,
                  revisionEntity: revisionEntity?.dateRevision,
                ),
                ChangeDateNextReview(
                  revisionEntity: revisionEntity?.dateRevision,
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
                try {
                  if (!formKey.currentState!.validate()) return;

                  var idRevision = await controller.saveOrUpdate(
                      revision: controller.revisionUsercase.buildRevision(
                          id: revisionEntity?.revision.id,
                          description: description.text,
                          dateCriational: FormatDate.formatDate(DateTime.now())),
                      update: revisionEntity != null ? true : false);

                  if (idRevision == null) return;

                  await controller.saveDateRevision(
                      controller.dateRevisionUsercase.builddateRevision(
                        id: revisionEntity?.dateRevision.id,
                        daRevision: FormatDate.formatDate(DateTime.now()),
                        hourInit: timeInit ??
                            revisionEntity?.dateRevision.hourInit ??
                            FormatDate.formatTimeByString(DateTime.now()),
                        hourEnd: timeEnd ??
                            revisionEntity?.dateRevision.hourEnd ??
                            FormatDate.formatTimeByString(DateTime.now()),
                        nextDate: dateNextRevision ?? FormatDate.formatDate(DateTime.now()),
                        idRevision: revisionEntity?.dateRevision.idRevision ?? idRevision,
                      ),
                      revisionEntity != null ? true : false);

                  if (context.mounted) {
                    controller.message(
                        context,
                        revisionEntity?.revision.id != null
                            ? 'Atualizado com sucesso'
                            : 'Registrado com sucesso');
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
