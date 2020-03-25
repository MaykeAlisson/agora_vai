import 'package:agora_vai/db/DbHelper.dart';

class Objetivo{

  int _id;
  String _descricao;
  int _qtdObjetivo;
  String _money;
  int _qtdLancamento;
  String _dtaCriacao;

  Objetivo(
      final String descricao,
      final int qtdObjetivo,
      final bool money
      ){
    this._descricao = descricao;
    this._qtdObjetivo = qtdObjetivo;
    this._money = money == true ? "S" : "N";
    this._qtdLancamento = null;
    this._dtaCriacao = new DateTime.now().toString();
  }

  String get dtaCriacao => _dtaCriacao;


  String get money => _money;

  set money(String value) {
    _money = value;
  }

  int get qtdObjetivo => _qtdObjetivo;

  set qtdObjetivo(int value) {
    _qtdObjetivo = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  int get id => _id;
  
  set id(int value) {
    _id = value;
  }


  int get qtdLancamento => _qtdLancamento;

  set qtdLancamento(int value) {
    _qtdLancamento = value;
  }

  Objetivo.fromMap(Map map){
    this._id = map[DBHelper.objetivoColumnId];
    this._descricao = map[DBHelper.objetivoColumnDescricao];
    this._qtdObjetivo = map[DBHelper.objetivooColumnQtdObjetivo];
    this._money = map[DBHelper.objetivoColumnMoney];
    this._dtaCriacao = map[DBHelper.objetivoColumnDtaCriacao];
  }

  Map toMap(){

    Map<String, dynamic> map = {
      DBHelper.objetivoColumnDescricao : this._descricao,
      DBHelper.objetivooColumnQtdObjetivo : this._qtdObjetivo,
      DBHelper.objetivoColumnMoney : this._money,
      DBHelper.objetivoColumnDtaCriacao : this._dtaCriacao,
      DBHelper.objetivoColumnQtdLancamento: this._qtdLancamento,
    };

    if(this._id != null){
      map[DBHelper.objetivoColumnId] = this._id;
    }

    return map;

  }


}