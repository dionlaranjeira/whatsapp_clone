import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/conversa.dart';
class Conversas extends StatefulWidget {
  const Conversas({Key? key}) : super(key: key);

  @override
  _ConversasState createState() => _ConversasState();
}

class _ConversasState extends State<Conversas> {


  List<Conversa> listaConversas = [
    Conversa(
        "Ana Clara",
        "Olá tudo bem?",
        "https://firebasestorage.googleapis.com/v0/b/whatapp-flutter.appspot.com/o/users%2Fanaclara.jpeg?alt=media&token=9f3a5263-f05c-46bd-9416-8c6c7b700311"
    ),
    Conversa(
        "Pedro Silva",
        "Me manda o nome daquela série que falamos!",
        "https://firebasestorage.googleapis.com/v0/b/whatapp-flutter.appspot.com/o/users%2F18404-gente-que-da-prioridade-aos-sentimentos-article_gallery-2.jpeg?alt=media&token=cf1710f2-7116-4343-b133-44490b390d30"
    ),
    Conversa(
        "Marcela Almeida",
        "Vamos sair hoje?",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil3.jpg?alt=media&token=99ad2441-7b1a-4940-879c-c62ae4535a01"
    ),
    Conversa(
        "José Renato",
        "Não vai acreditar no que tenho para te contar...",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil4.jpg?alt=media&token=ff26db77-6554-4072-a238-f06ba1af4e3d"
    ),
    Conversa(
        "Jamilton Damasceno",
        "Curso novo!! depois dá uma olhada!!",
        "https://firebasestorage.googleapis.com/v0/b/whatsapp-36cd8.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=f6fd2892-f8bd-47bc-b3fc-f0ba0a48fac5"
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listaConversas.length,
        itemBuilder: (context, indice){

          Conversa conversa = listaConversas[indice];

          return ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            leading: CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage( conversa.caminhoFoto ),
            ),
            title: Text(
              conversa.nome,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            subtitle: Text(
                conversa.mensagem,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14
                )
            ),
          );

        }
    );
  }
}
