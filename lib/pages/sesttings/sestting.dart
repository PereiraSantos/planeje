import 'package:flutter/material.dart';

import '../../usercase/date_mask.dart';
import '../../widgets/text_button_widget.dart';
import '../../widgets/text_form_field_widget.dart';
import '../register_revision/controller/revision_controller.dart';

class Sestting extends StatelessWidget {
  Sestting({super.key, this.id});
  final int? id;
  final RevisionController controller = RevisionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5c060),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xfff5c060),
        elevation: 0,
        title: const Text(
          "Configurações",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
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
                  hintText: 'Título',
                ),
                TextFormFieldWidget(
                  controller: controller.textDateNextRevisionController,
                  inputFormatter: [DateMask()],
                  keyboardType: TextInputType.datetime,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.date_range,
                    ),
                    color: Colors.black54,
                    iconSize: 25,
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025));

                      if (picked != null) {
                        controller.setValueDateRevision(picked);
                      }
                    },
                  ),
                ),
                TextFormFieldWidget(
                  controller: controller.textDescriptionController,
                  maxLine: 5,
                  hintText: 'Descrição/Observação',
                  valid: false,
                  keyboardType: TextInputType.multiline,
                  textArea: true,
                ),
                Visibility(
                  visible: id != null ? true : false,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 15, right: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Proximas revisões:',
                            style: TextStyle(fontSize: 19)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /*Text(
                              revisionEntity?.dateRevision ?? '',
                              style: const TextStyle(fontSize: 18),
                            ),*/
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.check),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /*Text(
                              revisionEntity?.nextRevision ?? '',
                              style: const TextStyle(fontSize: 18),
                            ),*/
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.check),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: const Color(0xfff5c060),
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButtonWidget(
                label: 'CANCELA', onClick: () => Navigator.pop(context, false)),
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
