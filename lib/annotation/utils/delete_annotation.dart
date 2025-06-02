import 'package:planeje/annotation/datasource/database/annotation_database.dart';
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

  @override
  Future<void> deleteTable() async {
    await annotationDatabase.deleteTable();
  }
}
