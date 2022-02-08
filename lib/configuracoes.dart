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

  TextEditingController _controllerNome = TextEditingController();
  late XFile _imagem;
  late String _idUsuarioLogado;
  bool _subindoImagem = false;
  late String _urlImagemRecuperada = "";

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
    File file = File(filePath);

    print("CAMINHO------>"+ filePath);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/file-to-upload.png')
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print("ERRO!!!"+ e.toString());
    }
  }


  // Future _uploadImagem() async {

    // FirebaseStorage storage = FirebaseStorage.instance;
    // StorageReference pastaRaiz = storage.ref();
    // StorageReference arquivo = pastaRaiz
    //   .child("perfil")
    //   .child(_idUsuarioLogado + ".jpg");
    //
    // //Upload da imagem
    // StorageUploadTask task = arquivo.putFile(_imagem);
    //
    // //Controlar progresso do upload
    // task.events.listen((StorageTaskEvent storageEvent){
    //
    //   if( storageEvent.type == StorageTaskEventType.progress ){
    //     setState(() {
    //       _subindoImagem = true;
    //     });
    //   }else if( storageEvent.type == StorageTaskEventType.success ){
    //     setState(() {
    //       _subindoImagem = false;
    //     });
    //   }
    //
    // });
    //
    // //Recuperar url da imagem
    // task.onComplete.then((StorageTaskSnapshot snapshot){
    //   _recuperarUrlImagem(snapshot);
    // });

  // }

  // Future<void> _recuperarUrlImagem() async {
  //   String downloadURL = await firebase_storage.FirebaseStorage.instance
  //       .ref('users/anaclara.jpeg')
  //       .getDownloadURL();
  //
  //   print("teste--->"+downloadURL.toString());
  //
  //   setState(() {
  //     _urlImagemRecuperada = downloadURL;
  //   });
  //
  //   // Within your widgets:
  //   // Image.network(downloadURL);
  // }


  // Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async {
  //
  //   String url = await snapshot.ref.getDownloadURL();
  //
  //   setState(() {
  //     _urlImagemRecuperada = url;
  //   });
  //
  // }

  // _recuperarDadosUsuario() async {
  //
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   FirebaseUser usuarioLogado = await auth.currentUser();
  //   _idUsuarioLogado = usuarioLogado.uid;
  //
  // }

  @override
  void initState() {
    super.initState();
    // _recuperarDadosUsuario();
    // _urlImagemRecuperada();
    // _recuperarUrlImagem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configurações"),),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _subindoImagem
                  ? CircularProgressIndicator()
                  : Container(),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                  _urlImagemRecuperada != null
                      ? NetworkImage(_urlImagemRecuperada)
                      : null
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: Text("Câmera"),
                      onPressed: (){
                        _recuperarImagem("camera");
                      },
                    ),
                    TextButton(
                      child: Text("Galeria"),
                      onPressed: (){
                        _recuperarImagem("galeria");
                      },
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        "Salvar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.green,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
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
