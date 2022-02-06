import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:whatsapp_clone/model/usuario.dart';
class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  var _mensagemErro = "";

  var _iconVisible = true;

  Future<void> _cadastrarUsuario(Usuario usuario) async {


    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usuario.email,
          password: usuario.senha
      );

      if( userCredential.user!= null){
        setState(() {
          _mensagemErro = "Usuario registrado com sucesso";
        });
      };

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          _mensagemErro = "Senha inválida";
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          _mensagemErro = "Usuário já possui cadastro ativo";
        });
      }
    } catch (e) {
      print(e);
    }


    // CollectionReference users = FirebaseFirestore.instance.collection('usuarios');
    //
    //   return users
    //       .add(usuario)
    //       .then((value) => print("User Added"))
    //       .catchError((error) => print("Failed to add user: $error"));

  }

  _validarDados(){

    if(_controllerNome.text.isEmpty){
      setState(() {
        _mensagemErro = "Insira o nome";
      });
    }else if(_controllerEmail.text.isEmpty || !_controllerEmail.text.contains("@")){
      setState(() {
        _mensagemErro = "Insira um email";
      });
    }
    else if(_controllerSenha.text.length<6){
      setState(() {
        _mensagemErro = "Senha inválida, insira pelo menos 6 dígitos";
      });
    }else{
      setState(() {
        _mensagemErro = "";
      });

      Usuario novoUsuario =
      Usuario(
          _controllerNome.text,
          _controllerEmail.text,
          _controllerSenha.text);

      _cadastrarUsuario(novoUsuario);

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("CADASTRO"),backgroundColor: const Color(0xff075e54),),
        body: Container(
          decoration: const BoxDecoration(color: Color(0xff075e54)),
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Image.asset("assets/images/usuario.png", width: 200, height: 150,),
                  ),

                  Padding(padding: const EdgeInsets.only(bottom: 8),
                    child: TextField(
                      controller: _controllerNome,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),

                      ),
                    ),
                  ),

                  Padding(padding: const EdgeInsets.only(bottom: 8),
                    child: TextField(
                      controller: _controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "E-mail",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),

                      ),
                    ),
                  ),

                  TextField(
                    controller: _controllerSenha,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 20),
                    obscureText: _iconVisible,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                      suffixIcon: IconButton(
                        icon: Icon(_iconVisible? Icons.visibility: Icons.visibility_off),
                        color: Colors.grey,
                        onPressed: (){
                          setState(() {
                            _iconVisible = !_iconVisible;
                          });
                        },
                      ),
                    ),
                  ),

                  Padding(padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: ElevatedButton(
                      onPressed: _validarDados,
                      child: const Text("Cadastrar",style: TextStyle(color: Colors.white, fontSize: 20),),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.greenAccent,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)
                        ),
                      ),
                    ),
                  ),

                  Center(child: Text(
                    _mensagemErro, textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red))),

                ],
              ),
            ),
          ),
        )
    );
  }
}
