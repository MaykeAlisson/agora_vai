import 'package:agora_vai/provider/HomeProvider.dart';
import 'package:agora_vai/screens/loading_screen.dart';
import 'package:agora_vai/ui/novo_usuario_page.dart';
import 'package:agora_vai/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => HomeProvider(),
        ),
      ],
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, widget) {
          return MaterialApp(
            title: 'Agora Vai!',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: homeProvider.jaEhUsuario ? Home() : NovoUsuarioScreen(),
          );
        },
      ),
    );
  }
}


