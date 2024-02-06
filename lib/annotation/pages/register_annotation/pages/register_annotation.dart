import 'package:flutter/material.dart';
import 'package:planeje/annotation/entities/annotation.dart';

import '../../../../widgets/text_button_widget.dart';
import '../component/drop_down_revision.dart';
import '../controller/register_annotation_controller.dart';

// ignore: must_be_immutable
class RegisterAnnotation extends StatelessWidget {
  RegisterAnnotation({super.key, this.annotation}) {
    textController.text = annotation?.text ?? '';
  }

  final Annotation? annotation;
  final formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  final RegisterAnnotationController controller = RegisterAnnotationController();
  int? idRevision;

  void message(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String title() => annotation != null ? "Atualizar" : "Adicionar";

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
                  onClick: (value) => idRevision = value, idRevision: annotation?.idRevision),
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
                if (!await controller.saveOrUpdate(textController.text,
                    id: annotation?.id, idRevision: idRevision ?? annotation?.idRevision)) {
                  return;
                }
                if (context.mounted) {
                  message(
                      context, annotation?.id != null ? 'Atualizado com sucesso' : 'Registrado com sucesso');
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
