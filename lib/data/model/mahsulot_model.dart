import 'package:category/data/db/crud_service.dart';
import 'package:category/data/db/db_initialize.dart';
import 'package:flutter/material.dart';

class MahsulotModel {
  static CrudService service = MahsulotService();
  static Map<int, MahsulotModel> obyektlar = {};

  int id = 0;
  String nomi = '';
  int narxi = 0;
  int categoryId = 0;

  MahsulotModel();

  MahsulotModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    nomi = json['nomi'].toString();
    narxi = int.parse(json['narxi'].toString());
    categoryId = int.parse(json['categoryId'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'narxi': narxi,
      'nomi':nomi,
      'categoryId': categoryId,
    };
  }

  @override
  String toString() {
    return '''
    id: $id
    narxi: $narxi
    nomi: $nomi
    categoryId: $categoryId,
    ''';
  }
  Future<int> insert() async {
    MahsulotModel.obyektlar[id] = this;
    id = await service.insert(toJson());
    return id;
  }

  Future<void> delete() async {
    MahsulotModel.obyektlar.remove(id);
    await service.delete(where: "id='$id'");
  }

  Future<void> update() async {
    MahsulotModel.obyektlar[id] = this;
    await service.update(toJson(), where: "id='$id'");
  }

}

class MahsulotService extends CrudService {
  @override
  MahsulotService({super.prefix = ''}) : super('mahsulotTable');


  static String createTableS = """                
  CREATE TABLE "mahsulotTable" (
  "id" INTEGER  NOT NULL DEFAULT 0,
  "narxi" INTEGER NOT NULL DEFAULT 0.0,
  "nomi" TEXT NOT NULL DEFAULT '',
  "categoryId" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY("id" AUTOINCREMENT)
  );
  """;

  @override
  Future<void> delete({String? where}) async {
    where = where == null ? "" : "WHERE $where";
    await db.query("DELETE FROM $table $where");
    debugPrint('MahsulotService "delete" methodi ishladi');
  }

  @override
  Future<int> insert(Map map) async {
    map['id'] = (map['id'] == 0) ? null : map['id'];
    var insertM = await db.insert(map as Map<String, dynamic>, table);
    debugPrint('MahsulotService "insert" methodi ishladi');
    return insertM;
  }

  @override
  Future<Map> select({String? where}) async {
    where = where == null ? "" : "WHERE $where";
    Map<int, dynamic> map = {};
    await for (final rows
        in db.watch("SELECT * FROM $table $where", tables: [table])) {
      for (final item in rows) {
        map[item['id']] = item;
      }
      return map;
    }
    debugPrint('MahsulotService "select" methodi ishladi');

    return map;
  }

  @override
  Future<void> update(Map map, {String? where}) async {
    where = where == null ? "" : "WHERE $where";

    String updateClause = "";
    final List params = [];
    final values = map.keys;

    for (String value in values) {
      if (updateClause.isNotEmpty) updateClause += ", ";
      updateClause += "$value=?";
      params.add(map[value]);
    }
    final String sql = "UPDATE $table SET $updateClause$where";
    await db.execute(sql, tables: [table], params: params);
    debugPrint('MahsulotService "update" methodi ishladi');
  }
}
