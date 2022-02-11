import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/contato.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/views/mensagem.dart';
class Contatos extends StatefulWidget {
  const Contatos({Key? key}) : super(key: key);

  @override
  _ContatosState createState() => _ContatosState();
}

class _ContatosState extends State<Contatos> {

  List<Contato> contatos = [];
  String _urlImagemRecuperada = "https://firebasestorage.googleapis.com/v0/b/whatapp-flutter.appspot.com/o/app%2Fuser.png?alt=media&token=a288df1e-378a-46b7-98b0-260200d4103b";

  Future<List<Contato>> _recuperaContatos() async{
    var currentUser = await FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('usuarios')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {

        if(doc["email"] != currentUser!.email) {
          Contato novoContato = Contato(doc["nome"], doc["email"], doc["urlIMGPerfil"]);
          contatos.add(novoContato);
        }

      });
    });

      return contatos;

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder <List<Contato>>(
        future: _recuperaContatos(),
        builder: (context, snapshot){
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  children: const [
                    Text("Carregando contatos"),
                    CircularProgressIndicator()
                  ],
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              return
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, indice) {
                    List<Contato>? listaItens = snapshot.data;
                    Contato contato = listaItens![indice];
                    return ListTile(
                      onTap: (){
                        Navigator.pushNamed(context, "/mensagem", arguments: contato.toMap());
                      },

                      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      leading: CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              NetworkImage(contato.fotoPerfil)),
                      title: Text(
                        contato.nome,
                        style:
                        const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    );
                  });
          }
        });
  }
}
