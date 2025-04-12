import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'revision_quiz')
class RevisionQuiz {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'date_revision')
  String? dateRevision;

  @ColumnInfo(name: 'answer')
  bool? answer;

  @ColumnInfo(name: 'id_quiz')
  int? idQuiz;

  RevisionQuiz({
    this.id,
    this.dateRevision,
    this.answer,
    this.idQuiz,
  });

  void setId(int? value) => id = value;
  void setDate({String? value}) => dateRevision = value ?? FormatDate.formatDateTime(DateTime.now());
  void setAnswer(bool? value) => answer = value;
  void setIdQuiz(int? value) => idQuiz = value;
}
