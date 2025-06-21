import 'package:flutter/material.dart';
import 'package:planeje/annotation/datasource/database/annotation_database.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/utils/find_annotation.dart';
import 'package:planeje/revision/datasource/database/date_revision_database.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/utils/format_date.dart';

// ignore: must_be_immutable
class ExpansionTileWidgets extends StatefulWidget {
  const ExpansionTileWidgets({
    super.key,
    required this.revision,
    required this.dateRevision,
    required this.onClick,
  });

  final Revision revision;
  final DateRevision dateRevision;
  final Function() onClick;

  @override
  State<ExpansionTileWidgets> createState() => _ExpansionTileWidgetsState();
}

class _ExpansionTileWidgetsState extends State<ExpansionTileWidgets> {
  bool reviser = false;

  String componentDate() {
    DateTime date = FormatDate.dateTimeParse(widget.dateRevision.dateRevision!);
    int day = FormatDate.newDate().difference(date).inDays;

    return day > 0 ? '- há $day dias' : '';
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false,
      title: Text(widget.revision.title ?? '', style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: Color.fromARGB(130, 0, 0, 0))),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Descrição: ${widget.revision.description ?? ''}', style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300)),
          Text(
              widget.dateRevision.dateRevision == null
                  ? 'Não revisada'
                  : 'Revisada: ${FormatDate.formatDateString(widget.dateRevision.dateRevision!)} ${componentDate()}',
              style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w300))
        ],
      ),
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      shape: const Border(),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Revisar', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  SizedBox(
                    width: 35,
                    height: 25,
                    child: IconButton(
                      onPressed: () async {
                        await RegisterDateRevision(DateRevisionDatabase(),
                            dateRevision: DateRevision(
                              dateRevision: FormatDate.formatDateStringNotification(DateTime.now()),
                              idRevision: widget.revision.id,
                              sync: false,
                              insertApp: true,
                            )).writeDateRevision().whenComplete(() => widget.onClick());
                      },
                      icon: const Icon(
                        Icons.replay_circle_filled_rounded,
                        color: Colors.black54,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 15),
              child: FutureBuilder(
                future: GetAnnotation(AnnotationDatabase()).getAnnotationWidthIdRevision(widget.revision.id!),
                builder: (BuildContext context, AsyncSnapshot<List<Annotation>?> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Card(
                        elevation: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 5, top: 5),
                              child: Text('Anotação', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Color.fromARGB(130, 0, 0, 0))),
                            ),
                            const Divider(),
                            ListView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: snapshot.data![index].title != '',
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Título: ',
                                                style: TextStyle(fontSize: 14, color: Color.fromARGB(170, 0, 0, 0)),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                snapshot.data![index].title ?? '',
                                                style: const TextStyle(fontSize: 14, color: Color.fromARGB(170, 0, 0, 0)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              'Descrição: ',
                                              style: TextStyle(fontSize: 13, color: Colors.black54),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Text(
                                              snapshot.data![index].text ?? '',
                                              style: const TextStyle(fontSize: 13, color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Padding(padding: EdgeInsets.all(2))
                                    ],
                                  ),
                                );
                              },
                            ),
                            const Padding(padding: EdgeInsets.all(2))
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            const Padding(padding: EdgeInsets.all(5))
          ],
        ),
      ],
    );
  }
}
