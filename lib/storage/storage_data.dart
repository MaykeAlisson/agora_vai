import 'package:agora_vai/db/DbHelper.dart';
import 'package:agora_vai/model/Objetivo.dart';
import 'package:mobx/mobx.dart';
part 'storage_data.g.dart';

/*
  APOS QUALQUER MUDANCA DEVEMOS RODAR O COMANDO:
  flutter packages pub run build_runner build
  PARA PODER GERAR O ARQUIVO ".g.dart" RESPONSAVEL
  POR ATUALIZAR O ESTADO DA APLICACAO.
 */

class Storage = _Storage with _$Storage;

abstract class _Storage with Store {
  // Data Base
  var _db = DBHelper();

  @observable
  List<Objetivo> objetivos;

  @observable
  int qtdObjetivos;

  @action
  atualizaListObjetivo() async {
    List<Objetivo> listaTemporaria = List<Objetivo>();
    List objetivosRecuperados = await _db.recuperarObjetivos();

    for(var item in objetivosRecuperados){
      Objetivo objetivo = Objetivo.fromMap(item);
      listaTemporaria.add(objetivo);
    }
    objetivos = listaTemporaria;
    listaTemporaria = null;
  }

  @action
  qtd_Objetivos(){
    qtdObjetivos = qtdObjetivos == null ? 0 : objetivos.length;
  }

}