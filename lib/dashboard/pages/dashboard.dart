import 'package:flutter/material.dart';

import 'package:planeje/dashboard/controller/reviser_notifier.dart';
import 'package:planeje/dashboard/controller/under_review_notifier.dart';
import 'package:planeje/dashboard/utils/check_setting.dart';
import 'package:planeje/dashboard/utils/find_revision.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ReviserNotifier reviserNotifier = ReviserNotifier();

  final UnderReviewNotifier underReviewNotifier = UnderReviewNotifier();

  void reloadPage() => setState(() {});

  @override
  void initState() {
    super.initState();
    CheckSetting().checkRealize();
    CheckSetting().checkNext();

    GetDelayedRevision(reviserNotifier).getRevision();
    GetCompletedRevision(reviserNotifier).getRevision();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          child:
              SizedBox() /*ListenableBuilder(
          listenable: reviserNotifier,
          builder: (BuildContext context, Widget? child) {
            return Column(
              children: [
                ReviserLate(
                  quantityCompleted: reviserNotifier.quantityReviserCompleted,
                  quantityDelayed: reviserNotifier.quantityReviserDelayed,
                ),
                ListenableBuilder(
                  listenable: underReviewNotifier,
                  builder: (BuildContext context, Widget? child) {
                    return UnderReview(
                      underReviewNotifier: underReviewNotifier,
                      finishReviser: () => reloadPage(),
                    );
                  },
                ),
                NextRevision(
                  future: NetRevisionTime(false).getNextRevision('realize'),
                  text: 'Realizar',
                  finishUpdaterReviser: () => reloadPage(),
                  underReviewNotifier: underReviewNotifier,
                ),
                NextRevision(
                  future: NetRevisionTime(true).getNextRevision('next'),
                  text: 'Próximas',
                  finishUpdaterReviser: () => reloadPage(),
                  underReviewNotifier: underReviewNotifier,
                ),
              ],
            );
          },
        ),*/
          ),
    );
  }
}
