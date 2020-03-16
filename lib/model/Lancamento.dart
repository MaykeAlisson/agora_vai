
import 'package:agora_vai/db/DbHelper.dart';

class Lancamento{

  int _id;
  int _idObjetivo;
  String _descricao;
  int _qtdLancamento;
  DateTime _dtaLancamento;

  Lancamento(
      final int idObjetivo,
      final String descricao,
      final int lancamento
      ){
      this._idObjetivo = idObjetivo;
      this._descricao = descricao;
      this._qtdLancamento = lancamento;
      this._dtaLancamento = new DateTime.now();
  }

  DateTime get dtaLancamento => _dtaLancamento;

  int get qtdLancamento => _qtdLancamento;

  set qtdLancamento(int value) {
    _qtdLancamento = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  int get idObjetivo => _idObjetivo;

  set idObjetivo(int value) {
    _idObjetivo = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }


  Lancamento.fromMap(Map map){
    this._id = map[DBHelper.lancamentoColumnId];
    this._idObjetivo = map[DBHelper.lancamentoColumnIdObjetivo];
    this._descricao = map[DBHelper.lancamentoColumnDescricao];
    this._qtdLancamento = map[DBHelper.lancamentoColumnQuanidade];
    this._dtaLancamento = map[DBHelper.lancamentoColumnDtaLancamento];
  }

  Map toMap(){

    Map<String, dynamic> map = {
      DBHelper.lancamentoColumnDescricao : this._descricao,
      DBHelper.lancamentoColumnIdObjetivo : this._idObjetivo,
      DBHelper.lancamentoColumnQuanidade : this._qtdLancamento,
      DBHelper.lancamentoColumnDtaLancamento : this._dtaLancamento,
    };

    if(this._id != null){
      map[DBHelper.lancamentoColumnId] = this._id;
    }

    return map;

  }


}