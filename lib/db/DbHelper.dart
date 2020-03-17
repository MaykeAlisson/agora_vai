import 'dart:io';
import 'package:agora_vai/model/Lancamento.dart';
import 'package:agora_vai/model/Objetivo.dart';
import 'package:agora_vai/model/Usuario.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {

  // Constantes
  static final String _databaseName = "agovai.db";
  static final _databaseVersion = 1;

  static final String tableUsuario = 'usuario';
  static final String usuarioColumnId = 'id';
  static final String usuarioColumnNome = 'nome';
  static final String usuarioColumnXp = 'xp';

  static final String tableLancamento = 'lancamento';
  static final String lancamentoColumnId = 'id';
  static final String lancamentoColumnDescricao = 'descricao';
  static final String lancamentoColumnQuanidade = 'quantidade';
  static final String lancamentoColumnDtaLancamento = 'criacao';
  static final String lancamentoColumnIdObjetivo = 'id_objetivo';

  static final String tableObjetivo = 'objetivo';
  static final String objetivoColumnId = 'id';
  static final String objetivoColumnDescricao = 'descricao';
  static final String objetivoColumnMoney = 'money';
  static final String objetivooColumnQtdObjetivo = 'qtd_objetivo';
  static final String objetivoColumnDtaCriacao = 'criacao';

  // torna esta classe singleton
  static final DBHelper _dbHelper = DBHelper.internal();
  Database _db;

  factory DBHelper(){
    return _dbHelper;
  }

  DBHelper.internal(){}

  get db async {
    if(_db != null){
      return _db;
    }else{
      _db = await inicializaDB();
      return _db;
    }
  }

  _oncreate(Database db, int version) async {

    String sql = "CREATE TABLE $tableUsuario("
        "$usuarioColumnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$usuarioColumnNome VARCHAR, "
        "$usuarioColumnXp INTEGER)";

    String sql1 = "CREATE TABLE $tableLancamento("
        "$lancamentoColumnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$lancamentoColumnDescricao VARCHAR, "
        "$lancamentoColumnQuanidade INTEGER,"
        "$lancamentoColumnDtaLancamento DATETIME,"
        "$lancamentoColumnIdObjetivo INTEGER)";

    String sql2 = "CREATE TABLE $tableObjetivo("
        "$objetivoColumnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$objetivooColumnQtdObjetivo INTEGER, "
        "$objetivoColumnDescricao VARCHAR, "
        "$objetivoColumnMoney INTEGER, "
        "$objetivoColumnDtaCriacao DATETIME)";

    await db.execute(sql);
    await db.execute(sql1);
    await db.execute(sql2);

  }

  inicializaDB() async{
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDeDados = join(caminhoBancoDados, _databaseName);

    var db = await openDatabase(localBancoDeDados, version: _databaseVersion, onCreate: _oncreate );
    return db;
  }

  Future<int> salvarUsuario(Usuario usuario) async {

    var bancoDeDados = await db;

    int result = await bancoDeDados.insert(tableUsuario, usuario.toMap());
    return result;
  }

  Future<int> salvarObjetivo(Objetivo objetivo) async {

    var bancoDeDados = await db;

    int result = await bancoDeDados.insert(tableObjetivo, objetivo.toMap());
    return result;
  }

  Future<int> salvarLancamento(Lancamento lancamento) async {

    var bancoDeDados = await db;

    int result = await bancoDeDados.insert(tableLancamento, lancamento.toMap());
    return result;
  }

  Future<bool> existeUsuario() async {

    var bancoDados = await db;
    String sql = "SELECT * FROM $tableUsuario ";
    var result = await bancoDados.rawQuery(sql);
    if(result != null){
      return true;
    }
    return false;
  }

  Future<Usuario> recuperaUsuario() async {

    var bancoDados = await db;
    String sql = "SELECT * FROM $tableUsuario";
    var result = await bancoDados.rawQuery(sql);
    Usuario usuario = Usuario.fromMap(result);
    return usuario;
  }

  Future<Usuario> recuperaUsuarioPorId(int id) async {

    var bancoDados = await db;
    String sql = "SELECT * FROM $tableUsuario WHERE $usuarioColumnId = $id";
    var result = await bancoDados.rawQuery(sql);
    Usuario usuario = Usuario.fromMap(result);
    return usuario;
  }

  Future<List> recuperarObjetivos() async {

    var bancoDados = await db;
    String sql = "SELECT * FROM $tableObjetivo ORDER BY $objetivoColumnDtaCriacao DESC";
    List objetivos = await bancoDados.rawQuery(sql);
    return objetivos;
  }

  Future<int> recuperarQtdLancamentos() async {

    var bancoDados = await db;
    String sql = "SELECT COUNT(*) FROM $tableLancamento ";
    return await bancoDados.rawQuery(sql);
  }

  Future<List> recuperarLancamentosPorObjetivos(int id) async {

    var bancoDados = await db;
    String sql = "SELECT * FROM $tableLancamento WHERE $lancamentoColumnIdObjetivo = $id ORDER BY data DESC";
    List lancamentos = await bancoDados.rawQuery(sql);
    return lancamentos;
  }

  Future<int> atualizaObjetivo(Objetivo objetivo) async {

    var bancoDeDados = await db;

    return await bancoDeDados.update(
        tableObjetivo,
        objetivo.toMap(),
        where: "id = ?",
        whereArgs: [objetivo.id]
    );
  }

  Future<int> atualizaLancamento(Lancamento lancamento) async {

    var bancoDeDados = await db;

    return await bancoDeDados.update(
        tableLancamento,
        lancamento.toMap(),
        where: "id = ?",
        whereArgs: [lancamento.id]
    );
  }

  Future<int> removerObjetivo(int id) async {
    var bancoDeDados = await db;

    return bancoDeDados.delete(
        tableObjetivo,
        where: "id = ?",
        whereArgs: [id]
    );
  }

  Future<int> removerLancamento(int id) async {
    var bancoDeDados = await db;

    return bancoDeDados.delete(
        tableLancamento,
        where: "id = ?",
        whereArgs: [id]
    );
  }

}
