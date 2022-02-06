import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
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
                    child: Image.asset("assets/images/usuario.png", width: 200, height: 150,),
                  ),

                  Padding(padding: const EdgeInsets.only(bottom: 8),
                    child: TextField(
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
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),

                    ),
                  ),

                  Padding(padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: ElevatedButton(
                      onPressed: (){},
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
                ],
              ),
            ),
          ),
        )
    );
  }
}