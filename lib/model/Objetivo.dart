import 'Lancamento.dart';

class Objetivo{

  int _id;
  String _descricao;
  bool _money = false;
  int _qtdObjetivo;
  DateTime _ano;
  DateTime _dtaCriacao;
  List<Lancamento> _lancamentos = [];

  Objetivo(
      final String descricao,
      final bool money,
      final int qtdObjetivo,
      final DateTime ano
      ){
    this._descricao = descricao;
    this._money = money;
    this._qtdObjetivo = qtdObjetivo;
    this._ano = ano;
    this._dtaCriacao = new DateTime.now();
  }

  DateTime get dtaCriacao => _dtaCriacao;

  DateTime get ano => _ano;

  set ano(DateTime value) {
    _ano = value;
  }

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

  List<Lancamento> get lancamentos => _lancamentos;

  set lancamentos(List<Lancamento> value) {
    _lancamentos = value;
  }


}