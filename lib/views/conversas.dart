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
        "Viih Tube",
        "Oi Dion, você está livre hoje? Saudades de você!",
        "https://rd1.com.br/wp-content/uploads/2021/11/20211114-viihposaex.jpg"
    ),
    Conversa(
        "Paola",
        "Tá de bobeira? Vamos dá uma volta?",
        "https://static1.purepeople.com.br/articles/8/31/68/48/@/3577245-paolla-oliveira-exibe-corpo-torneado-em-624x600-2.jpg"
    ),
    Conversa(
        "Camila Angel",
        "Oi Sumido!",
        "https://f.i.uol.com.br/fotografia/2021/11/17/1637172668619545bcbc76c_1637172668_3x2_md.jpg"
    ),
    Conversa(
        "Bruna do Ney",
        "Me bloqueou Dion? pq não me responde",
        "https://i1.wp.com/d1tr1z57agf4qv.cloudfront.net/wp-content/uploads/2019/11/24145953/Bruna-Marquezine.jpg?w=800&ssl=1"
    ),
    Conversa(
        "Anitta",
        "Dion, preciso falar com você, me liga.",
        "https://istoe.com.br/wp-content/uploads/sites/14/2021/09/anitta-1.jpg"
    ),
    Conversa(
        "Marina chata",
        "Não fala nada pra ninguem Dion",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPnptGb7YrMTvI39alr0rD_L4tMZw9NVnvAw&usqp=CAU"
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
