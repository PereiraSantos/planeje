import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'revision')
class Revision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'date_creational')
  String? dateCreational;

  @ColumnInfo(name: 'id_learn')
  int? idLearn;

  Revision({
    this.id,
    this.description,
    this.dateCreational,
    this.idLearn,
  });

  void setId(int? value) => id = value;
  void setDescription(String value) => description = value;
  void setDateCreational(String? value) =>
      dateCreational = value ?? FormatDate.formatDate(FormatDate.newDate());
  void setIdLearn(int? value) => idLearn = value;
}
