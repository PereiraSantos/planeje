import 'package:flutter/material.dart';
import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/utils/find_annotation.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/utils/format_date.dart';

class ExpansionTileWidgets extends StatefulWidget {
  const ExpansionTileWidgets({
    super.key,
    required this.revision,
  });

  final Revision revision;

  @override
  State<ExpansionTileWidgets> createState() => _ExpansionTileWidgetsState();
}

class _ExpansionTileWidgetsState extends State<ExpansionTileWidgets> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: false,
      title: Text(widget.revision.title ?? '', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: const Color.fromARGB(130, 0, 0, 0))),
      subtitle: Text('Conteúdo: ${widget.revision.description ?? ''}', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300)),
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      shape: Border(),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(left: 15, bottom: 5),
              child: Text(widget.revision.dateCreational != null ? FormatDate.formatDateString('${widget.revision.dateCreational}') : '',
                  style: TextStyle(fontSize: 13, color: Colors.black45)),
            ),
            FutureBuilder(
              future: GetAnnotation(AnnotationDatabase()).getAnnotationWidthIdRevision(widget.revision.id!),
              builder: (BuildContext context, AsyncSnapshot<List<Annotation>?> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 2),
                          child: Text('Anotação', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: const Color.fromARGB(130, 0, 0, 0))),
                        ),
                        ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: snapshot.data![index].title != '',
                                    child: Text(
                                      snapshot.data![index].title ?? '',
                                      style: TextStyle(fontSize: 14, color: const Color.fromARGB(170, 0, 0, 0)),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![index].text ?? '',
                                    style: TextStyle(fontSize: 13, color: Colors.black54),
                                  ),
                                  const Padding(padding: EdgeInsets.all(1))
                                ],
                              ),
                            );
                          },
                        ),
                        const Padding(padding: EdgeInsets.all(10))
                      ],
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
          ],
        ),
      ],
    );
  }
}
