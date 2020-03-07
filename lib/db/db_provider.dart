class DBProvider {
  static DBProvider _database;

  DBProvider._();
  static final DBProvider db = DBProvider._();
}