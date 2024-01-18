import 'package:floor/floor.dart';

@Entity(tableName: 'revision')
class Revision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'description')
  final String? description;

  @ColumnInfo(name: 'status')
  final bool? status;

  @ColumnInfo(name: 'date')
  final String? date;

  Revision({
    this.id,
    this.description,
    this.status = false,
    this.date,
  });
}
