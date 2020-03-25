import 'package:agora_vai/db/DbHelper.dart';
import 'package:agora_vai/model/Objetivo.dart';
import 'package:agora_vai/storage/storage_data.dart';
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

  // Storage Mobx
  final storage = Storage();

  final _form = GlobalKey<FormState>();
  List _objetivos;
  String _objetivo;
  int _meta;
  bool _isLoading = false;
  bool _money = false;

  void initState() {
    super.initState();
    _buscaNomeObjetivos();
  }

  _buscaNomeObjetivos() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List listaTemporaria = List();
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
    if(_objetivos == null){
      return false;
    }else {
      int index = _objetivos.indexOf(nome.toLowerCase());
      if (index == -1) {
        return false;
      }
      return true;
    }
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
      Objetivo objetivo = Objetivo(_objetivo.toLowerCase(), _meta, _money);
      int id = await  _db.salvarObjetivo(objetivo);
      if(id != null){
        await storage.atualizaListObjetivo();
      }
    } catch (e) {
      //print(e);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void _isMoney( bool money){
    setState(() {
      _money = money;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
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
                  onFieldSubmitted: (value) {
                    _salvar();
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Meta",
                      border: OutlineInputBorder()
                  ),
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value){
                    if (value.isEmpty) {
                      return 'Informe uma meta.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _meta = int.parse(value);
                    });
                  },
                  onFieldSubmitted: (value){
                   _salvar();
                  },
                ),
                SizedBox(height: 10,),
                CheckboxListTile(title: Text("Dinheiro"), value: _money, onChanged: _isMoney)
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
    ),
    );
  }
}
