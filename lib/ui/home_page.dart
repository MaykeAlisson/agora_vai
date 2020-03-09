import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


// Provider
import 'package:agora_vai/provider/home.dart';

// mes
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

  bool _isLoading = false;
  bool _isListLoading = false;

  // Atributos e Metodos
  int _counter = 0;

  @override
  void initState(){
    super.initState();
    buscaDados();
  }

  void buscaDados() async {
    setState(() {
      _isLoading = true;
    });
    try {
//      await Provider.of<HomeProvider>(context,listen:false).buscaTodosDados();
    }catch(e){
      //print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> removeCardObjetivo(String type) async {
    setState(() {
      _isListLoading = true;
    });
    try {
//      await Provider.of<HomeProvider>(context).deletaObjetivo(type);
    }catch(e){
      //print(e);
    }
    setState(() {
      _isListLoading = false;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Agora Vai!",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w600))),
        bottom: CustomAppBar(HomeProvider.getUserName.split(" ")[0],homeProvider.getTypes.length),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
