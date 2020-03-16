import 'package:agora_vai/db/DbHelper.dart';

class Usuario{
  int _id;
  String _nome;
  int _xp;

  Usuario(
      final String nome
      ){
    this._nome = nome;
  }


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Usuario.fromMap(Map map){
    this._id = map[DBHelper.usuarioColumnId];
    this._nome = map[DBHelper.usuarioColumnNome];
    this._xp = map[DBHelper.usuarioColumnXp];
  }

  Map toMap(){

    Map<String, dynamic> map = {
      DBHelper.usuarioColumnNome : this._nome,
      DBHelper.usuarioColumnXp : this._xp,
    };

    if(this._id != null){
      map[DBHelper.usuarioColumnId] = this._id;
    }

    return map;

  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get xp => _xp;

  set xp(int value) {
    _xp = value;
  }
}