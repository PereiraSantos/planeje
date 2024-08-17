import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';

abstract class DeleteAnnotationFactory {
  Future<Annotation?> delete(int id);
}

class DeleteAnnotation implements DeleteAnnotationFactory {
  AnnotationDatabaseFactory annotationDatabase;

  DeleteAnnotation(this.annotationDatabase);
  @override
  Future<Annotation?> delete(int id) async {
    return await annotationDatabase.delete(id);
  }
}
