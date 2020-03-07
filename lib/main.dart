import 'package:agora_vai/provider/home.dart';
import 'package:agora_vai/screens/loading_screen.dart';
import 'package:agora_vai/screens/novo_usuario_screen.dart';
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
            theme: ThemeData(
              primarySwatch: Colors.grey,
            ),
            home: homeProvider.jaEhUsuario ? Home() : NovoUsuarioScreen(),
//            home: homeProvider.jaEhUsuario ? Home() : FutureBuilder(
//              future: homeProvider.tryToGetData(),
//              builder: (context,result){
//                if(result.connectionState == ConnectionState.waiting){
//                  return LoadingScreen();
//                }else{
//                  return NovoUsuarioScreen();
//                }
//              },
//            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
