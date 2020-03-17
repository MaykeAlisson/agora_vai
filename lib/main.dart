import 'package:agora_vai/screens/loading_screen.dart';
import 'package:agora_vai/ui/home_page.dart';
import 'package:agora_vai/ui/novo_usuario_page.dart';
import 'package:flutter/material.dart';

import 'db/DbHelper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agora Vai!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MeuApp(),
    );
  }
}

class MeuApp extends StatelessWidget {
  // Data Base
  var _db = DBHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: verificaSeExisteDados(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingScreen();
        } else {
          if (snapshot.data == false) {
            return NovoUsuarioScreen();
          } else {
            return Home();
          }
        }
      },
    );
  }

  Future<bool> verificaSeExisteDados() async {
    var usuario = await _db.existeUsuario();
    if (usuario == false) {
      return false;
    }
    return true;
  }
}
