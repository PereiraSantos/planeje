import 'package:planeje/annotation/datasource/dao/annotation_dao_custom.dart';
import 'package:planeje/annotation/entities/annotation.dart';

import '../../../database/app_database.dart';
import '../../entities/annotation_revision.dart';

abstract class AnnotationDatabaseFactory {
  Future<int?> insertAnnotation(Annotation annotationEntity);
  Future<int?> updateAnnotation(Annotation annotationEntity);
  Future<void> delete(int id);
  Future<List<AnnotationRevision>?> getAnnotationWidthRevision(String text);
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision);
  Future<void> deleteByIdRevision(int id);
}

class AnnotationDatabase implements AnnotationDatabaseFactory {
  @override
  Future<void> delete(int id) async {
    final database = await getInstance();
    return await database.annotationDao.delete(id);
  }

  @override
  Future<int?> insertAnnotation(Annotation annotationEntity) async {
    final database = await getInstance();
    return await database.annotationDao.insertAnnotation(annotationEntity);
  }

  @override
  Future<int?> updateAnnotation(Annotation annotationEntity) async {
    final database = await getInstance();
    return await database.annotationDao.updateAnnotation(annotationEntity);
  }

  @override
  Future<List<AnnotationRevision>?> getAnnotationWidthRevision(String text) async {
    final database = await getInstance();
    return await AnnotationDaoCustom().getAnnotationWidthRevision(database, text);
  }

  @override
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision) async {
    final database = await getInstance();
    return await database.annotationDao.getAnnotationWidthIdRevision(idRevision);
  }

  @override
  Future<void> deleteByIdRevision(int id) async {
    final database = await getInstance();
    return await database.annotationDao.deleteByIdRevision(id);
  }
}
