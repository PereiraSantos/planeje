import 'package:flutter/material.dart';
import 'package:planeje/entities/date_revision.dart';
import '../../../database/app_database.dart';
import '../../../model/date_revision_model.dart';
import '../../../usercase/format_date.dart';
import '../../../entities/revision.dart';

class RevisionController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController textController = TextEditingController();
  final TextEditingController textSearchController = TextEditingController();
  final TextEditingController textDateRevisionController = TextEditingController();
  final TextEditingController textDateNextRevisionController = TextEditingController();
  final TextEditingController textDescriptionController = TextEditingController();

  List<DateRevisionModel> listDay = [];
  List<DateRevision> listDayRemoveById = [];
  TimeOfDay? selectedTime;
  bool status = false;

  Future<void> setValueListDay({int? id, required bool status}) async {
    final database = await getInstatceDataBase();
    database.dateRevisionDao.updateDateRevisionById(status, id!);
  }

  void buildListDay(List<DateRevisionModel> list) => listDay = list;

  Future<AppDatabase> getInstatceDataBase() async =>
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  Future<List<Revision>> getRevision({String? value}) async {
    final database = await getInstatceDataBase();

    return value != null && value != ""
        ? await database.revisionDao.findRevisionByDescription('%$value%')
        : await database.revisionDao.findAllRevisions();
  }

  Future<List<DateRevision>> getDateRevision(int id) async {
    final database = await getInstatceDataBase();
    return await database.dateRevisionDao.findDateRevisionById(id);
  }

  Future<bool> validateInput(int? id, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      id != null ? await updateRevision(id, context) : await insertRevision(context);

      return await Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  reviewedRevision(bool status, int id) async {
    final database = await getInstatceDataBase();
    database.dateRevisionDao.updateDateRevisionById(!status, id);
  }

  Future<void> insertRevision(BuildContext context) async {
    final database = await getInstatceDataBase();
    //await initAlarm();
    final revision = buildRevision();
    /*int id = await database.revisionDao.insertRevision(revision).whenComplete(() {
      message(context, "Registrado com sucesso!!!");
    });*/
    /* await database.dateRevisionDao
        .insertDateRevisionList(buildDateRevision(id));*/
  }

  Future<void> deleteRevisionController(int id, BuildContext context) async {
    final database = await getInstatceDataBase();
    //  await stopAlarm();
    database.revisionDao
        .deleteRevisionById(id)
        .whenComplete(() => message(context, "Excluido com sucesso!!!"));

    await database.dateRevisionDao.deleteDateRevisionById(id);
  }

  Future<void> updateRevision(int id, BuildContext context) async {
    final database = await getInstatceDataBase();

    await database.revisionDao
        .updateRevision(textDescriptionController.text, id, status)
        .whenComplete(() => message(context, "Atualizado com sucesso!!!"));

    List<DateRevision> listDateRevisionTemp = buildDateRevision(id);

    for (DateRevision element in listDateRevisionTemp) {
      DateRevision? listDateRevisionTemp =
          await database.dateRevisionDao.findDateRevisionByIdRevision(id, element.date!);
      if (listDateRevisionTemp?.date == null) {
        await database.dateRevisionDao.insertDateRevision(element);
      }
    }

    for (DateRevisionModel element in listDay) {
      if (element.delete!) {
        if (element.revisionId != null) {
          await database.dateRevisionDao.deleteDateRevisionByIdRevision(element.revisionId!, element.date!);
        }
      }
    }
  }

  void message(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Revision buildRevision() {
    DateTime dateNow = DateTime.now();
    String date = FormatDate.formatDate(dateNow);

    return Revision(
      text: textController.text,
      dateCriation: date,
      description: textDescriptionController.text,
      revision: date,
      nextRevision: textDateNextRevisionController.text,
    );
  }

  List<DateRevision> buildDateRevision(int id) {
    List<DateRevision> list = [];

    listDay.sort((a, b) => a.quantityDay!.compareTo(b.quantityDay!));

    for (var i = 0; i < listDay.length; i++) {
      list.add(
        DateRevision(
          revisionId: id,
          //date: FormatDate.formatDate(buildNextRevision(listDay[i].quantityDay!)),
          date: FormatDate.formatDateStringDb(textDateNextRevisionController.text),
          hour: selectedTime!.hour,
          minute: selectedTime!.minute,
        ),
      );
    }

    return list;
  }

  DateTime buildNextRevision(int day) {
    DateTime dateInput = FormatDate.dateParse(textDateNextRevisionController.text);

    dateInput = dateInput.add(Duration(days: day));

    return dateInput;
  }

  updateValue(Revision revisionEntity) {
    textController.text = revisionEntity.text!;
    textDateRevisionController.text = revisionEntity.dateCriation!;
    textDateNextRevisionController.text = revisionEntity.nextRevision!;
    textDescriptionController.text = revisionEntity.description ?? '';
  }

  initDate() => textDateNextRevisionController.text = FormatDate.formatDate(DateTime.now());

  setValueDateRevision(DateTime value) => textDateNextRevisionController.text = FormatDate.formatDate(value);

  /* Future<void> initAlarm() async {
    MethodChannel methodChannel = const MethodChannel('alarm/koltin');

    try {
      await methodChannel.invokeMethod("init",
          [selectedTime!.hour.toString(), selectedTime!.minute.toString()]);
    } on PlatformException catch (e) {
      log("$e");
    }
  }*/

  /*Future<void> stopAlarm() async {
    MethodChannel methodChannel = const MethodChannel('alarm/koltin');

    try {
      dynamic r = await methodChannel.invokeMethod("stop");
      print(r);
    } on PlatformException catch (e) {
      print("exceptiong");
    }
  }
  */
  void setTime(TimeOfDay value) => selectedTime = value;
}
