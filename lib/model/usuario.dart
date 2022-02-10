class Usuario{

  String _nome;
  String _email;
  String _senha;
  String? _urlIMGperfil;

  Usuario(this._nome, this._email, this._senha);

  Map toMap(){
    Map<String, dynamic> map = {
      "nome": _nome,
      "email": _email,
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


  String get urlIMGperfil => _urlIMGperfil!;

  set urlIMGperfil(String value) {
    _urlIMGperfil = value;
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