import 'package:flutter/material.dart';
import 'package:whatsapp_clone/home.dart';
import 'package:whatsapp_clone/views/cadastro.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  var _iconVisible = true;

  var _mensagemErro = "";

  _validarDados() {

    if(_controllerEmail.text.isEmpty){
      setState(() {
        _mensagemErro = "Insira o e-mail";
      });
    }else if(_controllerSenha.text.isEmpty){
      setState(() {
        _mensagemErro = "Insira a senha";
      });
    }else{
      _login();
    }

  }

  _login() async {

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerSenha.text
      );

      _verificaUsuarioLogado();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _mensagemErro = "Não existe usuário cadastrado com esse email.";
        });

      } else if (e.code == 'wrong-password') {
        setState(() {
          _mensagemErro = "Senha não confere.";
        });
      }
    }

  }

  _verificaUsuarioLogado() async {
    var currentUser = await FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
    }
  }

  @override
  void initState() {
    _verificaUsuarioLogado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Image.asset("assets/images/logo.png", width: 200, height: 150,),
                ),

                Center(child: Text(_mensagemErro, textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)),

                Padding(padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
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
                  child: const Text("Entrar",style: TextStyle(color: Colors.white, fontSize: 20),),
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

                GestureDetector(
                  child: const Text(
                    "Não tem conta? Cadastre-se!",
                    style: TextStyle(
                      color: Colors.white,

                    ),textAlign: TextAlign.center,
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Cadastro()));
                  },
                ),

              ],
            ),
          ),
        ),
      )
    );
  }
}
