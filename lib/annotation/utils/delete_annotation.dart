import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';

abstract class IDeleteAnnotation {
  Future<Annotation?> delete(int id);
}

class DeleteAnnotation implements IDeleteAnnotation {
  AnnotationDataSourceRepository annotationDatabase;

  DeleteAnnotation(this.annotationDatabase);
  @override
  Future<Annotation?> delete(int id) async {
    return await annotationDatabase.delete(id);
  }
}
