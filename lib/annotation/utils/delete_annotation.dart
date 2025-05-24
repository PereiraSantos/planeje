import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/utils/delete.dart';

abstract class DeleteAnnotationFactory extends DeleteFactory {}

class DeleteAnnotation implements DeleteAnnotationFactory {
  AnnotationDatabaseFactory annotationDatabase;

  DeleteAnnotation(this.annotationDatabase);
  @override
  Future<void> disableById(int id) async {
    return await annotationDatabase.disable(id);
  }

  @override
  Future<void> disableByIdRevision(int id) async {
    return await annotationDatabase.disableByIdRevision(id);
  }
}
