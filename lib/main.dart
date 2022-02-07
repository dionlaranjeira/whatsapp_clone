import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp_clone/views/welcome.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Welcome(),
    theme: ThemeData(
      primaryColor: const Color(0xff075e54),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff25D366)),
    ),
  ));
}

