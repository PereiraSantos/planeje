import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/utils/delete.dart';

abstract class DeleteAnnotationFactory extends DeleteFactory {}

class DeleteAnnotation implements DeleteAnnotationFactory {
  AnnotationDatabaseFactory annotationDatabase;

  DeleteAnnotation(this.annotationDatabase);
  @override
  Future<void> deleteById(int id) async {
    return await annotationDatabase.delete(id);
  }

  @override
  Future<void> deleteByIdRevision(int id) async {
    return await annotationDatabase.deleteByIdRevision(id);
  }
}
