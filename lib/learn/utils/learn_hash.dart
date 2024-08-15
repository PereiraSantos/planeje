import 'package:planeje/learn/entities/learn.dart';

class LearnHash {
  static final LearnHash _singleton = LearnHash._internal();

  LearnHash._internal();

  factory LearnHash() {
    return _singleton;
  }

  String? _hash;

  set hash(String? value) => _hash = value;
  String? get getHash => _hash;

  bool compare() {
    return true;
  }

  Future<List<Learn>>? getLearn() async {
    return [];
  }
}
