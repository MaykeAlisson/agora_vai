// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_data.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Storage on _Storage, Store {
  final _$objetivosAtom = Atom(name: '_Storage.objetivos');

  @override
  List<Objetivo> get objetivos {
    _$objetivosAtom.context.enforceReadPolicy(_$objetivosAtom);
    _$objetivosAtom.reportObserved();
    return super.objetivos;
  }

  @override
  set objetivos(List<Objetivo> value) {
    _$objetivosAtom.context.conditionallyRunInAction(() {
      super.objetivos = value;
      _$objetivosAtom.reportChanged();
    }, _$objetivosAtom, name: '${_$objetivosAtom.name}_set');
  }

  final _$qtdObjetivosAtom = Atom(name: '_Storage.qtdObjetivos');

  @override
  int get qtdObjetivos {
    _$qtdObjetivosAtom.context.enforceReadPolicy(_$qtdObjetivosAtom);
    _$qtdObjetivosAtom.reportObserved();
    return super.qtdObjetivos;
  }

  @override
  set qtdObjetivos(int value) {
    _$qtdObjetivosAtom.context.conditionallyRunInAction(() {
      super.qtdObjetivos = value;
      _$qtdObjetivosAtom.reportChanged();
    }, _$qtdObjetivosAtom, name: '${_$qtdObjetivosAtom.name}_set');
  }

  final _$atualizaListObjetivoAsyncAction = AsyncAction('atualizaListObjetivo');

  @override
  Future atualizaListObjetivo() {
    return _$atualizaListObjetivoAsyncAction
        .run(() => super.atualizaListObjetivo());
  }

  final _$_StorageActionController = ActionController(name: '_Storage');

  @override
  dynamic qtd_Objetivos() {
    final _$actionInfo = _$_StorageActionController.startAction();
    try {
      return super.qtd_Objetivos();
    } finally {
      _$_StorageActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'objetivos: ${objetivos.toString()},qtdObjetivos: ${qtdObjetivos.toString()}';
    return '{$string}';
  }
}
