import 'package:flutter_test/flutter_test.dart';
import 'package:planeje/learn/datasource/database/datasource_learn_repository.dart';
import 'package:planeje/learn/entities/learn.dart';
import 'package:planeje/learn/utils/delete_learn.dart';
import 'package:planeje/learn/utils/find_learn.dart';
import 'package:planeje/learn/utils/register_learn.dart';
import 'package:planeje/utils/type_message.dart';

class LearnDatabaseMock implements LearnDatabaseFactory {
  @override
  Future<Learn?> deleteLearnById(int id) async {
    return Learn(id: id, description: 'Delete teste');
  }

  @override
  Future<List<Learn>?> getAllLearn(String text) async {
    return [Learn(id: 1, description: text), Learn(id: 2, description: text)];
  }

  @override
  Future<Learn?> getLearnId(int id) async {
    return Learn(id: id, description: 'Descrição teste');
  }

  @override
  Future<int> insertLearn(Learn learn) async {
    return 1;
  }

  @override
  Future<int> updateLearn(Learn learn) async {
    return 1;
  }
}

void main() {
  test('Espero que registre um assunto', () async {
    var result =
        await SaveLearn(LearnDatabaseMock(), Learn(), StatusNotification(TypeMessage.Adicionar)).write();

    expect(1, result);
  });

  test('Espero que altere um assunto', () async {
    var result =
        await UpdateLearn(LearnDatabaseMock(), Learn(), StatusNotification(TypeMessage.Atualizar)).write();

    expect(1, result);
  });

  test('Espero que retorne um assunto por id', () async {
    var result = await GetLearn(LearnDatabaseMock()).getById(1);

    expect(1, result!.id!);
  });

  test('Espero que retorne todos os  assunto', () async {
    var result = await GetLearn(LearnDatabaseMock()).getAll('');

    expect(2, result!.length);
  });

  test('Espero que delete assunto', () async {
    var result = await DeleteLearn(LearnDatabaseMock()).deleteById(1);

    expect(1, result!.id);
  });
}
