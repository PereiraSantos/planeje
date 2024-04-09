import 'package:floor/floor.dart';

@Entity(tableName: 'revision')
class Revision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  final int? id;

  @ColumnInfo(name: 'description')
  final String? description;

  @ColumnInfo(name: 'date_creational')
  final String? dateCreational;

  Revision({
    this.id,
    this.description,
    this.dateCreational,
  });
}
