import 'package:floor/floor.dart';

@Entity(tableName: 'revision')
class Revision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'description')
  final String? description;

  @ColumnInfo(name: 'status')
  bool? status;

  @ColumnInfo(name: 'date')
  final String? date;

  @ColumnInfo(name: 'next_date')
  final String? nextDate;

  Revision({
    this.id,
    this.description,
    this.status = false,
    this.date,
    this.nextDate,
  });
}
