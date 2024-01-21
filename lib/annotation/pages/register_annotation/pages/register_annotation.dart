import 'package:flutter/material.dart';
import 'package:planeje/annotation/entities/annotation.dart';

import '../../../../widgets/text_button_widget.dart';
import '../controller/register_annotation_controller.dart';

class RegisterAnnotation extends StatelessWidget {
  RegisterAnnotation({super.key, this.annotation}) {
    textController.text = annotation?.text ?? '';
  }

  final Annotation? annotation;
  final formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  final RegisterAnnotationController controller = RegisterAnnotationController();

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
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: TextFormField(
            controller: textController,
            maxLines: 100,
            style: const TextStyle(fontSize: 22, color: Colors.black54),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Descrição aqui.',
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
                if (!await controller.saveOrUpdate(textController.text, id: annotation?.id)) {
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
