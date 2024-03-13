import 'package:flutter/material.dart';
import 'package:planeje/revision/entities/revision.dart';

import '../../revision/pages/list_revision/component/text_list.dart';
import '../../revision/pages/register_revision/page/register_revision.dart';
import '../../usercase/format_date.dart';
import '../../usercase/transitions_builder.dart';

class NextRevision extends StatelessWidget {
  const NextRevision({
    super.key,
    required this.future,
    required this.text,
    required this.finishUpdaterReviser,
  });

  final Future<List<Revision>?> future;
  final String text;
  final Function() finishUpdaterReviser;

  Widget labelText(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 5),
      child: SizedBox(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<Revision>?> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Column(
              children: [
                const Padding(padding: EdgeInsets.all(10)),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
                  ),
                ),
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        var result = await Navigator.of(context).push(
                          TransitionsBuilder.createRoute(
                            RegisterRevision(revisionEntity: snapshot.data![index]),
                          ),
                        );
                        if (result) finishUpdaterReviser();
                      },
                      child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          elevation: 8,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  labelText("Descrição:"),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: TextCard(
                                        padding: const EdgeInsets.only(left: 8, top: 05, right: 5),
                                        revisionEntity: snapshot.data![index].description ?? "",
                                        maxLines: 5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  labelText("Revisa em:"),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      child: TextCard(
                                        padding: const EdgeInsets.only(left: 8, right: 5, bottom: 5, top: 5),
                                        revisionEntity: FormatDate()
                                            .formatDateString(snapshot.data![index].nextDate ?? ""),
                                        maxLines: 5,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }

          return const SizedBox();
        } else {
          return const SizedBox(
            width: 15,
            height: 15,
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 1),
            ),
          );
        }
      },
    );
  }
}
