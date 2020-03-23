import 'package:agora_vai/db/DbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NovoObjetivo extends StatefulWidget {
  @override
  _NovoObjetivoState createState() => _NovoObjetivoState();
}

class _NovoObjetivoState extends State<NovoObjetivo> {
  // Data Base
  var _db = DBHelper();

  final _form = GlobalKey<FormState>();
  List<String> _objetivos;
  String _objetivo;
  bool _isLoading = false;

  void initState() {
    super.initState();
    _buscaNomeObjetivos();
  }

  _buscaNomeObjetivos() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<String> listaTemporaria = List<String>();
      listaTemporaria = await _db.buscaNomeObjetivos();
      setState(() {
        _objetivos = listaTemporaria;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool jaExisteObjetivo(String nome) {
    int index = _objetivos.indexOf(nome.toLowerCase());
    if (index == -1) {
      return false;
    }
    return true;
  }

  Future<void> _salvar() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
//      bool success = await Provider.of<HomeProvider>(context).addObjetivo(_objetivo.toLowerCase());


    } catch (e) {
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
      title: Text("Add novo objetivo",
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 20))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Descrição objetivo",
                  ),
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Descrição obrigatoria.';
                    }
                    if (jaExisteObjetivo(value)) {
                      return 'Objetivo já existe.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _objetivo = value;
                    });
                  },
//                  onFieldSubmitted: (value) {
//                    _salvar();
//                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Quantidade",
                      border: OutlineInputBorder()
                  ),
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value){
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value){
                    setState(() {
//                      _taskName= value;
                    });
                  },
                ),
              ],
            )
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancelar",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontWeight: FontWeight.w500))),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: _isLoading
              ? CircularProgressIndicator()
              : Text(
                  "Add",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontWeight: FontWeight.w500)),
                ),
          onPressed: () {
            _salvar();
          },
        ),
      ],
    );
  }
}
