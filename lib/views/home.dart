import 'package:flutter/material.dart';
import 'package:whatsapp_clone/configuracoes.dart';
import 'package:whatsapp_clone/views/contatos.dart';
import 'package:whatsapp_clone/views/conversas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/views/login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>with SingleTickerProviderStateMixin {

  late TabController _tabController;

  List<String> menus = ["Configurações", "Deslogar"];

  List<Widget> telas = [
    const Conversas(),
    const Contatos()
  ];

  _escolhaMenuItem(String itemEscolhido){
    switch(itemEscolhido){
      case "Configurações":
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Configuracoes()));
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  _deslogarUsuario() async{

    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Login()));

  }
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2,
        vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff075e54),
        title: const Text("WhatsApp"),
        bottom: TabBar(
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Conversas",),
            Tab(text: "Contatos",),
          ],
        ),
        actions:[
         PopupMenuButton<String>(
             onSelected: _escolhaMenuItem,
             itemBuilder: (context){
               return menus.map((String item) {
                 return PopupMenuItem<String>(
                   value: item,
                  child: Text(item)
               );
               }).toList();
             })
        ],
      ),

      body: TabBarView(
        controller: _tabController,
        children: const [
          Conversas(),
          Contatos(),
        ],
      ),
    );
  }
}
