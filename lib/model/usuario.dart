class Usuario{

  String _nome;
  String _email;
  String _senha;
  String _urlIMGPerfil;

  Usuario(this._nome, this._email, this._senha, this._urlIMGPerfil);

  Map toMap(){
    Map<String, dynamic> map = {
      "nome": _nome,
      "email": _email,
      "urlIMGPerfil": _urlIMGPerfil,
    };
    return map;
  }

  Map toContato(String nome, String email, String urlFoto){
    Map<String, dynamic> map = {
      "nome": nome,
      "email": email,
      "urlIMGPerfil": urlFoto,
    };
    return map;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }


  String get urlIMGperfil => _urlIMGPerfil!;

  set urlIMGPerfil(String value) {
    _urlIMGPerfil = value;
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