import 'dart:developer';

class ExceptionDb implements Exception{
  void errMsg() => log('Erro ao inserir no banco');
}

class ExceptionList implements Exception{
  void errMsg(error) => 'Erro ao buscar lista-> $error';
}

class ExceptionInsert implements Exception{
  void errMsg(error) => 'Erro ao inserir-> $error';
}


class ExceptionDelete implements Exception{
  void errMsg(error) => 'Erro ao deletar-> $error';
}

class ExceptionUpdate implements Exception{
  void errMsg(error) => 'Erro ao fazer update-> $error';
}