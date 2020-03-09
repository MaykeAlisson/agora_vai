import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//providers
import '../provider/home.dart';

class NovoObjetivo extends StatefulWidget {
  @override
  _NovoObjetivoState createState() => _NovoObjetivoState();
}

class _NovoObjetivoState extends State<NovoObjetivo> {
  final _form = GlobalKey<FormState>();
  List<String> _objetivos;
  String _objetivo;
  bool _isLoading = false;

  void initState(){
    super.initState();
    _objetivos = Provider.of<HomeProvider>(context,listen: false).getObjetivos;
  }

  bool alreadyExists(String type){
    int index = _objetivos.indexOf(type.toLowerCase());
    if(index==-1){
      return false;
    }
    return true;
  }

  Future<void> _onSubmit() async{
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try{
      bool success = await Provider.of<HomeProvider>(context).addObjetivo(_objetivo.toLowerCase());
      if(success){
        //print("Add Dialog success, popping off");
      }
    }catch(e){
      //print(e);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text("Add novo objetivo",style:GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 20))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: _form,
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Descrição objetivo",
              ),
              autocorrect: true,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              validator: (value){
                if (value.isEmpty) {
                  return 'Descrição obrigatoria.';
                }
                if(alreadyExists(value)){
                  return 'Objetivo já existe.';
                }
                return null;
              },
              onChanged: (value){
                setState(() {
                  _objetivo = value;
                });
              },
              onFieldSubmitted: (value){
                _onSubmit();
              },
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancelar",style: GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.w500))),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: _isLoading ? CircularProgressIndicator() : Text("Add",style: GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.w500)),),
          onPressed: (){
            _onSubmit();
          },
        ),
      ],
    );
  }
}
