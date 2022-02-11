import 'package:flutter/material.dart';
import 'package:whatsapp_clone/util/colors.dart';

class Mensagem extends StatefulWidget {
  final dynamic contato;
  const Mensagem({Key? key, required this.contato}) : super(key: key);

  @override
  _MensagemState createState() => _MensagemState();
}

class _MensagemState extends State<Mensagem> {

  TextEditingController _controllerMensagem = TextEditingController();

  _enviarMensagem(){
  }

  _enviarFoto(){
  }

  @override
  Widget build(BuildContext context) {

    var caixaMensagem = Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                controller: _controllerMensagem,
                autofocus: true,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                    hintText: "Digite uma mensagem...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32)
                    ),
                    prefixIcon: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: _enviarFoto
                    )
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Color(UtilColors.BG_GREEN),
            child: Icon(Icons.send, color: Colors.white,),
            mini: true,
            onPressed: _enviarMensagem,
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.contato["nome"]),backgroundColor: Color(UtilColors.BG_GREEN),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover
            )
        ),
        child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Text("listview"),
                  caixaMensagem,
                  //listview
                  //caixa mensagem
                ],
              ),
            )
        ),
      ),
    );
  }
}
