import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'date_revision')
class DateRevision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id_date')
  int? id;

  @ColumnInfo(name: 'date_revision')
  String? dateRevision;

  @ColumnInfo(name: 'next_date_revision')
  String? nextDate;

  @ColumnInfo(name: 'hour_init')
  String? hourInit;

  @ColumnInfo(name: 'hour_end')
  String? hourEnd;

  @ColumnInfo(name: 'id_revision')
  int? idRevision;

  DateRevision({
    this.id,
    this.dateRevision,
    this.nextDate,
    this.hourInit,
    this.hourEnd,
    this.idRevision,
  });

  set setId(int? value) => id = value;
  set setDate(String? value) => dateRevision = value ?? FormatDate.formatDate(DateTime.now());
  set setNextDate(String? value) => nextDate = value ?? FormatDate.formatDate(DateTime.now());
  set setHourInit(String? value) => hourInit = value ?? FormatDate.formatTimeByString(DateTime.now());
  set setHourEnd(String? value) => hourEnd = value ?? FormatDate.formatTimeByString(DateTime.now());
  set setIdRevision(int? value) => idRevision = value;
}
