import 'package:planeje/annotation/datasource/dao/annotation_dao_custom.dart';
import 'package:planeje/annotation/entities/annotation.dart';

import '../../../database/app_database.dart';
import '../../entities/annotation_revision.dart';

abstract class AnnotationDatabaseFactory {
  Future<int?> insertAnnotation(Annotation annotationEntity);
  Future<List<int>> insertAnnotationList(List<Annotation> annotations);
  Future<int?> updateAnnotation(Annotation annotationEntity);
  Future<void> delete(int id);
  Future<List<AnnotationRevision>?> getAnnotationWidthRevision(String text);
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision);
  Future<void> deleteByIdRevision(int id);
  Future<List<Annotation>?> getAnnotationAll();
  Future<List<Annotation>?> findAnnotationSync();
  Future<void> updateAnnotationList(List<Annotation> annotation);
  Future<Annotation?> findAnnotationByIdExternal(int idExternal);
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

  @override
  Future<List<int>> insertAnnotationList(List<Annotation> annotations) async {
    final database = await getInstance();
    return await database.annotationDao.insertAnnotationList(annotations);
  }

  @override
  Future<List<Annotation>?> getAnnotationAll() async {
    final database = await getInstance();
    return await database.annotationDao.getAnnotationAll();
  }

  @override
  Future<List<Annotation>?> findAnnotationSync() async {
    final database = await getInstance();
    return await database.annotationDao.findAnnotationSync();
  }

  @override
  Future<void> updateAnnotationList(List<Annotation> annotation) async {
    final database = await getInstance();
    return await database.annotationDao.updateAnnotationList(annotation);
  }

  @override
  Future<Annotation?> findAnnotationByIdExternal(int idExternal) async {
    final database = await getInstance();
    return await database.annotationDao.findAnnotationByIdExternal(idExternal);
  }
}
