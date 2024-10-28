import 'package:flutter/material.dart';
import 'package:planeje/dashboard/component/button_time_revision.dart';
import 'package:planeje/dashboard/controller/under_review_notifier.dart';
import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/utils/find_date_revision.dart';
import 'package:planeje/widgets/card_revision.dart';

class UnderReview extends StatelessWidget {
  const UnderReview({
    super.key,
    required this.underReviewNotifier,
    required this.finishReviser,
  });

  final UnderReviewNotifier underReviewNotifier;
  final Function() finishReviser;

  Future<List<RevisionTime>?> findDateRevision() async {
    int id = underReviewNotifier.getIdDateRevision();
    if (id == -1) id = await underReviewNotifier.getIdDateRevisionPref();

    return FindDateRevision(DateRevisionDatabaseDataSource()).findDateRevisionByIdDate(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: findDateRevision(),
      builder: (BuildContext context, AsyncSnapshot<List<RevisionTime>?> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return Column(
              children: [
                const Divider(color: Colors.grey, endIndent: 15, indent: 15),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    'Em Revisão',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black54),
                  ),
                ),
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: CardRevision(
                        revisionTime: snapshot.data![index],
                        isRevision: true,
                        child: ButtonTimeRevision(
                          revisionTime: snapshot.data![index],
                          underReviewNotifier: underReviewNotifier,
                          finishReviser: () => finishReviser(),
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
