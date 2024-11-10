import 'package:flutter/material.dart';
import 'package:planeje/annotation/entities/annotation_revision.dart';

class FilterNotifier with ChangeNotifier {
  List<AnnotationRevision>? _annotationsRevisions = [];

  List<AnnotationRevision>? get annotationsRevisions => _annotationsRevisions;

  void setAnnotation(List<AnnotationRevision> value) {
    _annotationsRevisions = value;
  }

  void update() => notifyListeners();
}
