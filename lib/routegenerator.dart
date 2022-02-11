import 'package:flutter/material.dart';
import 'package:whatsapp_clone/views/mensagem.dart';
import 'package:whatsapp_clone/views/welcome.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/welcome":
        return MaterialPageRoute(
            builder: (_) => const Welcome()
        );

      case "/mensagem":
        return MaterialPageRoute(
            builder: (_) => Mensagem(contato: settings.arguments,)
        );
    }

    return _erroRota();
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(
        builder: (_) {
          return Scaffold(
            appBar: AppBar(title: const Text("Intranet Caer"),),
            body: const Center(
                child: Text("Tela não encontrada")
            ),
          );
        }
    );
  }

}