import 'package:flutter/material.dart';

import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/widgets/bottom_sheet/bottom_sheet_widget.dart';
import '../../../../utils/message_user.dart';
import '../../../../widgets/text_button_widget.dart';
import '../../../../widgets/text_form_field_widget.dart';
import '../component/change_date_next_review.dart';
import '../component/change_time_revision.dart';

// ignore: must_be_immutable
class RegisterRevisionPage extends StatelessWidget {
  RegisterRevisionPage({super.key, required this.revision}) {
    description.text = revision.revision.description ?? '';
  }

  IRevision revision;
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
                  onClickTimeInit: (time) => revision.registerDate.date.setHourInit = time,
                  onClickTimeEnd: (time) => revision.registerDate.date.setHourEnd = time,
                  revisionEntity: revision.registerDate.date,
                ),
                ChangeDateNextReview(
                  revisionEntity: revision.registerDate.date,
                  onClickCalendar: (value) => nextDate = value,
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

                revision.revision.setId = revision.revision.id;
                revision.revision.setDescription = description.text;
                revision.revision.setDateCreational = revision.revision.dateCreational;

                var idRevision = await revision.writeRevision();

                if (idRevision == null) return;

                revision.registerDate.date.setDate = revision.registerDate.date.dateRevision;
                revision.registerDate.date.setHourInit = revision.registerDate.date.hourInit;
                revision.registerDate.date.setHourEnd = revision.registerDate.date.hourEnd;
                revision.registerDate.date.setIdRevision = revision.revision.id ?? idRevision;
                revision.registerDate.date.setNextDate = nextDate;

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
