import 'package:flutter/material.dart';
import 'package:planeje/dashboard/controller/build_data_graphic.dart';
import 'package:planeje/revision/datasource/database/date_revision_database_datasource.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/widgets/chart_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void reloadPage() => setState(() {});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        toolbarHeight: 46,
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: DateRevisionDatabaseDataSource().findAllDateRevisions(),
          builder: (BuildContext context, AsyncSnapshot<List<DateRevision>?> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChartWidget(data: BuildDataGraphic().buildRevisionYear(snapshot.data ?? []), title: 'Ano'),
                    Padding(padding: EdgeInsets.all(10)),
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    "Não há revisões!!!",
                    style: TextStyle(fontSize: 22, color: Colors.black54, fontWeight: FontWeight.w300),
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
