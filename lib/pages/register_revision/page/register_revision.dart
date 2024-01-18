import 'package:flutter/material.dart';
import '../../../model/date_revision_model.dart';
import '../../../entities/revision.dart';
import '../../../usercase/date_mask.dart';
import '../../../usercase/format_date.dart';
import '../../../widgets/text_button_widget.dart';
import '../../../widgets/text_form_field_widget.dart';
import '../component/next_review.dart';
import '../controller/revision_controller.dart';

// ignore: must_be_immutable
class RegisterRevision extends StatelessWidget {
  RegisterRevision({Key? key, this.revisionEntity, this.dateRevisionModel}) : super(key: key) {
    if (revisionEntity != null) {
      controller.updateValue(revisionEntity!);
      id = revisionEntity!.id!;
    } else {
      controller.initDate();
    }
  }

  final Revision? revisionEntity;
  int? id;
  final RevisionController controller = RevisionController();
  final List<DateRevisionModel>? dateRevisionModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          id != null ? "Atualizar" : "Adicionar",
          style: const TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFieldWidget(
                  controller: controller.textController,
                  maxLine: 3,
                  hintText: 'Revisão',
                ),
                TextFormFieldWidget(
                  controller: controller.textDescriptionController,
                  maxLine: 5,
                  hintText: 'Descrição',
                  valid: false,
                  keyboardType: TextInputType.multiline,
                  textArea: true,
                ),
                TextFormFieldWidget(
                  controller: controller.textDateRevisionController,
                  readOnly: id != null ? true : false,
                  inputFormatter: [DateMask()],
                  keyboardType: TextInputType.datetime,
                  hintText: "Revisar em",
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.date_range,
                    ),
                    color: Colors.black54,
                    iconSize: 22,
                    onPressed: () async {
                      if (id == null) {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (picked != null) {
                          controller.setValueDateRevision(picked);
                        }
                      } else {
                        controller.message(context, "Não é possivel editar");
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: id != null ? true : false,
                  child: NextReview(
                    controller: controller.textDateNextRevisionController,
                    onClick: (value) {
                      controller.status = value;
                      if (value) {
                        controller.textDateRevisionController.text = FormatDate.formatDate(DateTime.now());
                      } else {
                        controller.textDateRevisionController.text = revisionEntity!.dateCriation!;
                      }
                    },
                    onClickCalendar: (picked) => controller.setValueDateRevision(picked),
                  ),
                ),

                /*Timer(controller: controller),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 15),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      "Intervalo da revisão em dias",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black45,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                 DropDownButtonCustom(
                  onClick: (list) => controller.buildListDay(list),
                  dateRevisionModel: dateRevisionModel ?? [],
                ),*/
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
              label: id != null ? 'EDITAR' : 'SALVAR',
              onClick: () async {
                bool result = await controller.validateInput(id, context);
                if (result) {
                  // ignore: use_build_context_synchronously
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
