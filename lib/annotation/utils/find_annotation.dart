import 'package:planeje/annotation/datasource/database/database_datasource.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/entities/annotation_revision.dart';

abstract class IFindAnnotation {
  Future<List<AnnotationRevision>?> getAnnotationWidthRevision();
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision);
}

class GetAnnotation implements IFindAnnotation {
  AnnotationDataSourceRepository annotationDatabase;

  GetAnnotation(this.annotationDatabase);

  @override
  Future<List<AnnotationRevision>?> getAnnotationWidthRevision() async {
    return await annotationDatabase.getAnnotationWidthRevision();
  }

  @override
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision) async {
    return await annotationDatabase.getAnnotationWidthIdRevision(idRevision);
  }
}
