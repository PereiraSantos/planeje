import 'annotation.dart';

class AnnotationRevision extends Annotation {
  final String? description;
  final String? descriptionCategory;
  final bool? status;
  final String? date;
  final String? nextDate;

  AnnotationRevision({
    this.descriptionCategory,
    this.description,
    this.status,
    this.date,
    this.nextDate,
    super.title,
    super.id,
    super.text,
    super.dateText,
  });

  static AnnotationRevision fromJson(Map<String, dynamic> json) => AnnotationRevision(
        title: json['title'] != null ? json['title'] as String? : null,
        description: json['description'] != null ? json['description'] as String? : null,
        descriptionCategory: json['descriptionCategory'] != null ? json['descriptionCategory'] as String? : null,
        status: json['status'] != null
            ? json['status'] == 0
                ? true
                : false
            : null,
        date: json['date'] != null ? json['date'] as String? : null,
        nextDate: json['next_date'] != null ? json['next_date'] as String? : null,
        id: json['id'] as int?,
        text: json['text'] as String?,
        dateText: json['date_text'] as String?,
      );
}
