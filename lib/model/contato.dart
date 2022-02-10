class Contato {

  String _nome;
  String _email;
  String _fotoPerfil;

  Contato(this._nome, this._email, this._fotoPerfil);

  String get fotoPerfil => _fotoPerfil;

  set fotoPerfil(String value) {
    _fotoPerfil = value;
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