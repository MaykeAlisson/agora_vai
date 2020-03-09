import 'Lancamento.dart';

class Objetivo{

  int _id;
  String _descricao;
  int _qtdObjetivo;
  DateTime _dtaCriacao;

  Objetivo(
      final String descricao,
      final int qtdObjetivo
      ){
    this._descricao = descricao;
    this._qtdObjetivo = qtdObjetivo;
    this._dtaCriacao = new DateTime.now();
  }

  DateTime get dtaCriacao => _dtaCriacao;

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


}