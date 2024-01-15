import 'package:category/data/model/category_model.dart';
import 'package:category/data/model/mahsulot_model.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';
import 'package:path/path.dart';

SQLiteWrapper db = SQLiteWrapper();

class DatabaseInitialize {
  DatabaseInitialize._init();

  static final DatabaseInitialize _singleton = DatabaseInitialize._init();

  factory DatabaseInitialize() {
    return _singleton;
  }

  static int version = 1;

  Future<DatabaseInfo> initDb(dbPath, {inMemory = false}) async {
    dbPath = join(dbPath, 'base.sqlite');
    return db.openDB(dbPath, onCreate: _onCreate, version: version);
  }

  Future<void> _onCreate() async {
    List<String> sql = [];
    sql.add(CategoryService.createCategoryTable);
    sql.add(MahsulotService.createTableS);
    for (var query in sql) {
      db.execute(query);
    }
  }
}
