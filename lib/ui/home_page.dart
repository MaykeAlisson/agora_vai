import 'package:agora_vai/db/DbHelper.dart';
import 'package:agora_vai/model/Objetivo.dart';
import 'package:agora_vai/model/Usuario.dart';
import 'package:agora_vai/screens/loading_screen.dart';
import 'package:agora_vai/ui/nova_tarefa_page.dart';
import 'package:agora_vai/ui/novo_objetivo_page.dart';
import 'package:agora_vai/ui/objetivo_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/Mes.dart' as mes;

int date = DateTime.now().day;
int m = DateTime.now().month;
String month = mes.months[m];
int year = DateTime.now().year;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Data Base
  var _db = DBHelper();

  bool _isLoading = false;
  bool _isListLoading = false;
  String _nome;
  int _xp;
  int _lancamentos;
  int _qtdObjetivo = 3;
  List<Objetivo> _listObjetivos = List<Objetivo>();

  void buscaDados() async {
    setState(() {
      _isListLoading = true;
    });

    List<Objetivo> listaTemporaria = List<Objetivo>();

    try {
      Usuario usuario = await _db.recuperaUsuario();
      setState(() {
        _nome = usuario.nome;
        _xp = usuario.xp;
      });
      Objetivo obj = new Objetivo("mayke", 10, false);
      listaTemporaria.add(obj);
      Objetivo obj2 = new Objetivo("alisson", 20, false);
      listaTemporaria.add(obj2);
      Objetivo obj3 = new Objetivo("mayke", 10, false);
      listaTemporaria.add(obj3);
      Objetivo obj4 = new Objetivo("mayke", 10, false);
      listaTemporaria.add(obj4);
      Objetivo obj5 = new Objetivo("mayke", 10, false);
      listaTemporaria.add(obj5);
      setState(() {
        _listObjetivos = listaTemporaria;
      });
    } catch (e) {
      //print(e);
    } finally {
      setState(() {
        _isListLoading = false;
      });
    }
  }

  Future<void> removeCardObjetivo(String type) async {
    setState(() {
      _isListLoading = true;
    });
    try {
//      await Provider.of<HomeProvider>(context).deletaObjetivo(type);
    } catch (e) {
      //print(e);
    }
    setState(() {
      _isListLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    buscaDados();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return _isLoading
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.blue,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text("Agora Vai!",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600))),
              bottom: Perfil(_nome, _qtdObjetivo),
            ),
            body: _listObjetivos.length == 0
                ? Center(
                    child: Text("Nenhum Objetivo Cadastrado",
                        style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                        )))
                : _isListLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: _listObjetivos.length,
                        itemBuilder: (context, index) {
                          final objetivo = _listObjetivos[index];
                          return Center(
                            child: SingleChildScrollView(
                                child: ObjetivoCard(
                              altura: height,
                              largura: width,
                              nome: objetivo.descricao,
                              total: objetivo.qtdObjetivo,
                              deleteFunction: () {},
                            )),
                          );
                        },
                      ),
          );
  }
}

class Perfil extends StatelessWidget with PreferredSizeWidget {
  final String _userName;
  final int _qtdObjetivo;

  Perfil(this._userName, this._qtdObjetivo);

  final size = AppBar().preferredSize * 2.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 20),
      height: size.height,
      width: AppBar().preferredSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Ola, $_userName",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              )),
          SizedBox(
            height: 15,
          ),
          Text(
            "Acompanhe seu desenvolvimento.",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white70, wordSpacing: 1, fontSize: 15)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "$date, $month $year".toUpperCase(),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Colors.white60, fontSize: 13)),
                textAlign: TextAlign.left,
              ),
              Wrap(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.assignment,
                      color: Colors.white,
                    ),
                    tooltip: "Add Objetivo",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return NovoObjetivo();
                          });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                    tooltip: "Add Tarefa",
                    onPressed: () {
                      if (_qtdObjetivo >= 1) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return NovaTarefa();
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text("Primeiro add um objetivo",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20))),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Fechar",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w500))),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      }
                    },
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => size;
}
