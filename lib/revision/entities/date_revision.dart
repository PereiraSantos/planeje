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

  @ColumnInfo(name: 'status')
  bool? status;

  DateRevision({
    this.id,
    this.dateRevision,
    this.nextDate,
    this.hourInit,
    this.hourEnd,
    this.idRevision,
    this.status,
  });

  void setId(int? value) => id = value;
  void setDate(String? value) => dateRevision = value ?? FormatDate.formatDate(DateTime.now());
  void setNextDate(String? value) => nextDate = value ?? FormatDate.formatDate(DateTime.now());
  void setHourInit(String? value) => hourInit = value ?? FormatDate.formatTimeByString(DateTime.now());
  void setHourEnd(String? value) => hourEnd = value ?? FormatDate.formatTimeByString(DateTime.now());
  void setIdRevision(int? value) => idRevision = value;
  void setStatus(bool? value) => status = value;
}
