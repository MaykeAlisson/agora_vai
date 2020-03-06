
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


}