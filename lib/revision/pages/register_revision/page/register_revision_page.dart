import 'package:flutter/material.dart';
import 'package:planeje/revision/pages/register_revision/component/drop_down_button_custom_revision.dart';

import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/widgets/bottom_sheet/bottom_sheet_widget.dart';
import '../../../../utils/message_user.dart';
import '../../../../widgets/text_button_widget.dart';
import '../../../../widgets/text_form_field_widget.dart';
import '../component/change_date_next_review.dart';

// ignore: must_be_immutable
class RegisterRevisionPage extends StatelessWidget {
  RegisterRevisionPage({super.key, required this.revision}) {
    description.text = revision.revision.description ?? '';
  }

  RevisionFactory revision;
  final formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();
  String nextDate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          revision.message.getTypeQuiz!.name,
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
                DropDownButtonCustomRevision(
                  onClick: (value) => revision.revision.setIdLearn(value),
                  idLearn: revision.revision.idLearn,
                ),
                TextFormFieldWidget(
                  controller: description,
                  maxLine: 5,
                  hintText: 'Tema',
                  keyboardType: TextInputType.multiline,
                  textArea: true,
                ),
                ChangeDateNextReview(
                  revisionEntity: revision.registerDate.date,
                  onClickCalendar: (value) => nextDate = value,
                  onDay: (value) => revision.registerDate.date.setDay(value),
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

                revision.revision.setDescription(description.text);

                var idRevision = await revision.write();

                if (idRevision == null) return;

                revision.registerDate.date.setDate(revision.registerDate.date.dateRevision);
                revision.registerDate.date.setIdRevision(revision.revision.id ?? idRevision);
                revision.registerDate.date.setNextDate(nextDate);
                revision.registerDate.date.setDay(revision.registerDate.date.day);

                if (nextDate == '') {
                  revision.registerDate.date.setNextDate(null);
                  revision.registerDate.date.setDay(0);
                }

                var result = await revision.registerDate.writeDateRevision();

                if (result != null && context.mounted) {
                  MessageUser.message(context, revision.message.message);
                  Navigator.pop(context, true);
                }
              } catch (e) {
                if (!context.mounted) return;
                MessageUser.message(context, 'Erro ao registrar!!!');
              }
            },
          ),
        ],
      ),
    );
  }
}
