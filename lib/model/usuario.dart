class Usuario{

  String _nome;
  String _email;
  String _senha;

  Usuario(this._nome, this._email, this._senha);

  Map toMap(){
    Map<String, dynamic> map = {
      "nome": _nome,
      "email": _email,
    };
    return map;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}