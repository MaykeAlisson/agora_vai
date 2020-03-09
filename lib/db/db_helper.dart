import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {

  static final _databaseName = "agovai.db";
  static final _databaseVersion = 1;

  static final tableUsuario = 'usuario';
  static final usuarioColumnId = '_id';
  static final usuarioColumnNome = 'nome';

  static final tableLancamento = 'lancamento';
  static final lancamentoColumnId = '_id';
  static final lancamentoColumnDescricao = 'descricao';
  static final lancamentoColumnQuanidade = 'quantidade';
  static final lancamentoColumnDtaLancamento = 'criacao';
  static final lancamentoColumnIdObjetivo = '_idObjetivo';

  static final tableObjetivo = 'objetivo';
  static final objetivoColumnId = '_id';
  static final objetivooColumnQtdObjetivo = 'qtdObjetivo';
  static final objetivoColumnDtaCriacao = 'criacao';

  // torna esta classe singleton
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  // tem somente uma referência ao banco de dados
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // Código SQL para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableUsuario (
            $usuarioColumnId INTEGER PRIMARY KEY,
            $usuarioColumnNome TEXT NOT NULL
          )
           CREATE TABLE $tableLancamento (
            $lancamentoColumnId INTEGER PRIMARY KEY,
            $lancamentoColumnDescricao TEXT NOT NULL,
            $lancamentoColumnQuanidade INTEGER NOT NULL,
            $lancamentoColumnDtaLancamento TEXT NOT NULL,
            $lancamentoColumnIdObjetivo INTEGER NOT NULL,
          )
           CREATE TABLE $tableObjetivo (
            $objetivoColumnId INTEGER PRIMARY KEY,
            $objetivooColumnQtdObjetivo INTEGER NOT NULL,
            $objetivoColumnDtaCriacao TEXT NOT NULL
          )
          ''');
  }

  // métodos Helper
  //----------------------------------------------------
  // Insere uma linha no banco de dados onde cada chave
  // no Map é um nome de coluna e o valor é o valor da coluna.
  // O valor de retorno é o id da linha inserida.
  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // Todas as linhas são retornadas como uma lista de mapas, onde cada mapa é
  // uma lista de valores-chave de colunas.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }
  // Todos os métodos : inserir, consultar, atualizar e excluir,
  // também podem ser feitos usando  comandos SQL brutos.
  // Esse método usa uma consulta bruta para fornecer a contagem de linhas.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }
  // Assumimos aqui que a coluna id no mapa está definida. Os outros
  // valores das colunas serão usados para atualizar a linha.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }
  // Exclui a linha especificada pelo id. O número de linhas afetadas é
  // retornada. Isso deve ser igual a 1, contanto que a linha exista.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

}