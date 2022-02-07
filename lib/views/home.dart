import 'package:flutter/material.dart';
import 'package:whatsapp_clone/views/contatos.dart';
import 'package:whatsapp_clone/views/conversas.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>with SingleTickerProviderStateMixin {

  late TabController _tabController;

  List<Widget> telas = [
    const Conversas(),
    const Contatos()
  ];

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
        title: const Text("WhatsApp clone"),
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
