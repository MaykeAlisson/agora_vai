import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


// Provider
import 'package:agora_vai/provider/HomeProvider.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Agora Vai!",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w600))),
//        bottom: CustomAppBar(HomeProvider.getUserName.split(" ")[0],homeProvider.getTypes.length),
        bottom: CustomAppBar("Mayke",3),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {

  final String _userName;
  final int _qtdObjetivo;
  CustomAppBar(this._userName,this._qtdObjetivo);
  final size = AppBar().preferredSize*2.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30,right: 20),
      height: size.height,
      width: AppBar().preferredSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Ola, $_userName",style: GoogleFonts.poppins(textStyle : TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w400),)),
          SizedBox(height: 15,),
          Text("Acompanhe seu desenvolvimento.",style: GoogleFonts.poppins( textStyle: TextStyle(color: Colors.white70 ,wordSpacing: 1,fontSize: 15)),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("$date, $month $year".toUpperCase(),style: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white60,fontSize: 13)),textAlign: TextAlign.left,),
              Wrap(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.assignment,color: Colors.white,),
                    tooltip: "Add Objetivo",
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context){
//                            return NewTypeDialog();
                          return null;
                          }
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle_outline,color: Colors.white,),
                    tooltip: "Add Tarefa",
                    onPressed: (){
                      if(_qtdObjetivo >= 1){
                        showDialog(
                            context: context,
                            builder: (context){
//                              return NewAllTaskDialog();
                              return null;
                            }
                        );
                      }else{
                        showDialog(
                            context: context,
                            builder: (ctx){
                              return AlertDialog(
                                title: Text("Primeiro add um objetivo",style:GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 20))),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Fechar",style: GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.w500))),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            }
                        );
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
