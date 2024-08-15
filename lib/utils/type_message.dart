// ignore: constant_identifier_names
enum TypeMessage { Adicionar, Atualizar }

class StatusNotification {
  TypeMessage? _type;
  String? _message;

  StatusNotification([this._type]) {
    _type = _type ?? TypeMessage.Adicionar;
    setType(_type!);
  }

  void setType(TypeMessage value) {
    _type = value;
    _message =
        _type?.index == TypeMessage.Adicionar.index ? 'Registrado com sucesso' : 'Atualizado com sucesso';
  }

  TypeMessage? get getTypeQuiz => _type;

  String get message => _message ?? '';
}
