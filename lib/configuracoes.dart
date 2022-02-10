import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {

  final TextEditingController _controllerNome = TextEditingController();
  late XFile _imagem;
  bool _subindoImagem = false;
  late String _urlImagemRecuperada = "http://www.caer.com.br/ws3/fotoUsuario?username=wilgner.schuertz&width=500";


  Future _recuperarImagem(String origemImagem) async {

    final ImagePicker _picker = ImagePicker();

    XFile? imagemSelecionada;
    switch( origemImagem ){
      case "camera" :
        imagemSelecionada = await _picker.pickImage(source: ImageSource.camera);
        break;
      case "galeria" :
        imagemSelecionada = await _picker.pickImage(source: ImageSource.gallery);
        break;
    }

    setState(() {
      _imagem = imagemSelecionada!;
      if( _imagem != null ){
        _subindoImagem = true;
        _uploadImagem(imagemSelecionada.path);
      }
    });

  }

  Future<void> _uploadImagem(String filePath) async {
    var currentUser = await FirebaseAuth.instance.currentUser;
    File file = File(filePath);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('users/perfil/${currentUser?.uid}.jpg')
          .putFile(file);

      downloadURLIMGPerfil();
    }
    on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> downloadURLIMGPerfil() async {
    var currentUser = await FirebaseAuth.instance.currentUser;
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('users/perfil/${currentUser?.uid}.jpg')
        .getDownloadURL();

    setState(() {
      _urlImagemRecuperada = downloadURL;
      _subindoImagem = false;
    });
  }

  @override
  void initState() {
    super.initState();
    downloadURLIMGPerfil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações"),),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _subindoImagem
                  ? const CircularProgressIndicator()
                  : Container(),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(_urlImagemRecuperada)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: const Text("Câmera"),
                      onPressed: (){
                        _recuperarImagem("camera");
                      },
                    ),
                    TextButton(
                      child: const Text("Galeria"),
                      onPressed: (){
                        _recuperarImagem("galeria");
                      },
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: ElevatedButton(
                      child: const Text(
                        "Salvar",
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                      ),
                      onPressed: () {

                      }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
