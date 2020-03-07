import 'package:agora_vai/provider/home.dart';
import 'package:agora_vai/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

//providers
import 'package:provider/provider.dart';

//screen

class NovoUsuarioScreen extends StatefulWidget {
  
  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NovoUsuarioScreen> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  String _userName;

  void _createUser() async {
    // Todo pega o nome do usuario e cria uma conta com o nome e um objetivo default
    setState(() {
      _isLoading = true;
    });

    try {
//      bool isCreated = await Provider.of<HomeProvider>(context).createNewUserData(_userName);
     // todo cria usuario
      bool usuarioCriado = true;
      if(usuarioCriado){
        //print("New User Created");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Home())
        );
      }else{
        showDialog(
          context: context,
          builder: (ctx){
            return AlertDialog();
          }
        ); 
      }
    }catch(e){
      //print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100,left: 40,right: 40,bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Ola,\n",style: GoogleFonts.poppins(textStyle: TextStyle(color:Colors.blue,fontSize: 25,fontWeight: FontWeight.w600))),
                    TextSpan(text: "Faça parte do Agora Vai!,\n",style: GoogleFonts.poppins(textStyle: TextStyle(color:Colors.blue))),
                  ]
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Form(
                    key: _form,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Digite seu nome"
                      ),
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value){
                        if (value.isEmpty) {
                          return 'Nome e obrigatorio.';
                        }
                        setState(() {
                          _userName = value;
                        });
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  RaisedButton(
                    color: Colors.blue,
                    child: _isLoading ? CircularProgressIndicator() : 
                      Text("Criar Conta",style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white),)),
                    onPressed: () {
                     _createUser();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}