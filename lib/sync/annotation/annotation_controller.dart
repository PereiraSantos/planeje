import 'package:planeje/annotation/datasource/database/annotation_database.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/utils/delete_annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';

class AnnotationController {
  List<Annotation> annotations = [];

  Future<bool> writeAnnotation() async {
    if (annotations.isNotEmpty) await InsertAnnotation(AnnotationDatabase(), annotations: annotations).writeList();

    return true;
  }

  Future<void> deleteTable() async => await DeleteAnnotation(AnnotationDatabase()).deleteTable();
}
