import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/views/home.dart';
import 'package:whatsapp_clone/views/login.dart';
class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  _verificaUsuarioLogado() async {
    var currentUser = await FirebaseAuth.instance.currentUser;


    if (currentUser != null) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
      });

    }else{
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login()));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _verificaUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff075e54),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 200, height: 150,),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
