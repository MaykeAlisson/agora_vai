import 'Lancamento.dart';

class Objetivo{

  int _id;
  String _descricao;
  bool _money = false;
  int _qtdObjetivo;
  DateTime _dtaCriacao;

  Objetivo(
      final String descricao,
      final bool money,
      final int qtdObjetivo
      ){
    this._descricao = descricao;
    this._money = money;
    this._qtdObjetivo = qtdObjetivo;
    this._dtaCriacao = new DateTime.now();
  }

  DateTime get dtaCriacao => _dtaCriacao;

  int get qtdObjetivo => _qtdObjetivo;

  set qtdObjetivo(int value) {
    _qtdObjetivo = value;
  }

  bool get money => _money;

  set money(bool value) {
    _money = value;
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