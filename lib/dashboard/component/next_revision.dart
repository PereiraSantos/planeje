import 'package:flutter/material.dart';
import 'package:planeje/revision/entities/revision.dart';

import '../../revision/pages/list_revision/component/text_list.dart';
import '../../usercase/format_date.dart';
import '../controller/dashboard_controller.dart';

class NextRevision extends StatelessWidget {
  const NextRevision({super.key, required this.dashboardController});

  final DashboardController dashboardController;

  Widget labelText(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 5),
      child: SizedBox(
        child: Text(
          label,
          style: const TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dashboardController.getNextRevision(),
      builder: (BuildContext context, AsyncSnapshot<Revision> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.id != null) {
            return Container(
              width: double.maxFinite,
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 5, top: 10),
                    alignment: Alignment.bottomLeft,
                    child: const Text(
                      "Proxima revisão",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                  ),
                  Card(
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
                                  revisionEntity: snapshot.data?.description ?? "",
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
                            labelText("Criado em:"),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                width: double.maxFinite,
                                child: TextCard(
                                  padding: const EdgeInsets.only(left: 8, top: 05, right: 5),
                                  revisionEntity: FormatDate().formatDateString(snapshot.data?.date ?? ""),
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
                                  revisionEntity:
                                      FormatDate().formatDateString(snapshot.data?.nextDate ?? ""),
                                  maxLines: 5,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
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
