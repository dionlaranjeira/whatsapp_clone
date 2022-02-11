import 'package:flutter/material.dart';

class Mensagem extends StatefulWidget {
  final dynamic contato;
  const Mensagem({Key? key, required this.contato}) : super(key: key);

  @override
  _MensagemState createState() => _MensagemState();
}



class _MensagemState extends State<Mensagem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.contato["nome"]),backgroundColor: const Color(0xff075e54)),
    );
  }
}
