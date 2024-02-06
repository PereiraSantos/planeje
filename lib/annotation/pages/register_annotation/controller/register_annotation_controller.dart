import '../../../datasource/database/database_datasource.dart';
import '../../../usercase/annotation_usercase.dart';
import '../../../usercase/buld_annotatiom.dart';

class RegisterAnnotationController {
  final AnnotationUsercase annotationUsercase = AnnotationUsercase(AnnotationDatabaseDatasource());
  final BuildAnnotation buildAnnotation = BuildAnnotation();

  Future<bool> saveOrUpdate(String text, {int? id, int? idRevision}) async {
    var result = id != null
        ? await annotationUsercase.updateAnnotation(text, id)
        : await annotationUsercase.insertAnnotation(buildAnnotation.build(text, idRevision));

    if (idRevision != null && id != null) await annotationUsercase.updateAnnotationRevision(idRevision, id);

    return result != null ? true : false;
  }
}
