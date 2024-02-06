import 'package:planeje/annotation/datasource/repository/annotation_datasource_repository.dart';
import 'package:planeje/annotation/entities/annotation.dart';

import '../../../database/app_database.dart';
import '../../entities/annotation_revision.dart';
import 'dao/annotation_dao_custom.dart';

class AnnotationDatabaseDatasource implements AnnotationDataSourceRepository {
  Future<AppDatabase> getInstance() async {
    return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  @override
  Future<Annotation?> delete(int id) async {
    final database = await getInstance();
    return await database.annotationDao.delete(id);
  }

  @override
  Future<List<Annotation>> findAllAnnotation() async {
    final database = await getInstance();
    return await database.annotationDao.findAllAnnotation();
  }

  @override
  Future<Annotation?> findAnnotationById(int id) async {
    final database = await getInstance();
    return await database.annotationDao.findAnnotationById(id);
  }

  @override
  Future<int?> insertAnnotation(Annotation annotationEntity) async {
    final database = await getInstance();
    return await database.annotationDao.insertAnnotation(annotationEntity);
  }

  @override
  Future<Annotation?> updateAnnotation(String text, int id) async {
    final database = await getInstance();
    return await database.annotationDao.updateAnnotation(text, id);
  }

  @override
  Future<Annotation?> updateAnnotationData(String data, int id) async {
    final database = await getInstance();
    return await database.annotationDao.updateAnnotationData(data, id);
  }

  @override
  Future<Annotation?> updateAnnotationTime(String time, int id) async {
    final database = await getInstance();
    return await database.annotationDao.updateAnnotationTime(time, id);
  }

  @override
  Future<Annotation?> updateAnnotationRevision(int idRevision, int id) async {
    final database = await getInstance();
    return await database.annotationDao.updateAnnotationRevision(idRevision, id);
  }

  @override
  Future<List<AnnotationRevision>?> getAnnotationWidthRevision() async {
    final database = await getInstance();
    return await AnnotationDaoCustom().getAnnotationWidthRevision(database);
  }

  @override
  Future<List<Annotation>?> findAnnotationByIdRevision(int idRevision) async {
    final database = await getInstance();
    return await database.annotationDao.findAnnotationByIdRevision(idRevision);
  }
}
