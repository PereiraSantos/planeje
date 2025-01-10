import 'package:flutter/material.dart';
import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:planeje/widgets/dialog_annotation.dart';
import '../../../../utils/message_user.dart';
import '../../../../widgets/text_button_widget.dart';
import '../../../../widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class RegisterRevisionPage extends StatefulWidget {
  RegisterRevisionPage({super.key, required this.revision, this.annotations});

  RevisionFactory revision;
  List<Annotation>? annotations;

  @override
  State<RegisterRevisionPage> createState() => _RegisterRevisionPageState();
}

class _RegisterRevisionPageState extends State<RegisterRevisionPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  InsertAnnotation registerAnnotation = InsertAnnotation(AnnotationDatabase(), Annotation(), StatusNotification());
  String nextDate = '';

  @override
  void initState() {
    super.initState();
    description.text = widget.revision.revision.description ?? '';
    title.text = widget.revision.revision.title ?? '';
    widget.annotations = [];
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
          widget.revision.message.getTypeQuiz!.name,
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
                  controller: title,
                  maxLine: 1,
                  hintText: 'Título',
                  keyboardType: TextInputType.text,
                  textArea: false,
                ),
                TextFormFieldWidget(
                  controller: description,
                  maxLine: 5,
                  hintText: 'Conteúdo',
                  keyboardType: TextInputType.multiline,
                  textArea: true,
                ),
                TextButton(
                  onPressed: () async {
                    await DialogAnnotation().build(context, <AnnotationRevision>(String title, String description) async {
                      widget.annotations!.add(Annotation(title: title, text: description));
                      setState(() {});
                    });
                  },
                  child: Text('Adicionar anotação', style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
                ListView.separated(
                  itemCount: widget.annotations!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  separatorBuilder: (context, index) {
                    return const Divider(endIndent: 5, indent: 5);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Título: ${widget.annotations![index].title}', style: TextStyle(color: Colors.black54)),
                        Text('Descrição: ${widget.annotations![index].text}', style: TextStyle(color: Colors.black54)),
                      ],
                    );
                  },
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
                FocusScope.of(context).requestFocus(FocusNode());

                widget.revision.revision.setTitle(title.text);
                widget.revision.revision.setDescription(description.text);
                widget.revision.revision.setDateCreational(widget.revision.revision.dateCreational);

                var idRevision = await widget.revision.write();

                if (idRevision == null) return;

                for (Annotation e in widget.annotations!) {
                  registerAnnotation.annotation.setTitle(e.title ?? '');
                  registerAnnotation.annotation.setText(e.text ?? '');
                  registerAnnotation.annotation.setIdRevision(idRevision);
                  registerAnnotation.annotation.setDateText(null);

                  await registerAnnotation.write();
                }

                widget.revision.registerDate.date.setDate(widget.revision.registerDate.date.dateRevision);
                widget.revision.registerDate.date.setIdRevision(widget.revision.revision.id ?? idRevision);
                widget.revision.registerDate.date.setNextDate(nextDate);
                widget.revision.registerDate.date.setDay(widget.revision.registerDate.date.day);

                if (nextDate == '') {
                  widget.revision.registerDate.date.setNextDate(null);
                  widget.revision.registerDate.date.setDay(0);
                }

                var result = await widget.revision.registerDate.writeDateRevision();

                if (result != null && context.mounted) {
                  MessageUser.message(context, widget.revision.message.message);
                  Navigator.pop(context, true);
                }
              } catch (e) {
                if (context.mounted) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  MessageUser.message(context, 'Erro ao registrar!!!');
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
