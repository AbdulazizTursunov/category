import 'package:category/data/db/crud_service.dart';
import 'package:category/data/db/db_initialize.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  static CrudService service = CategoryService();
  static Map<int, CategoryModel> obyektlar = {};

  int id = 0;
  String nomi = '';

  CategoryModel();

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    nomi = json['nomi'].toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "nomi": nomi,
    };
  }

  @override
  String toString() {
    return '''
    id: $id
    nomi: $nomi
    ''';
  }

  Future<int> insert() async {
    CategoryModel.obyektlar[id] = this;
    id = await service.insert(toJson());
    return id;
  }

  Future<void> delete() async {
    CategoryModel.obyektlar.remove(id);
    await service.delete(where: "id='$id'");
  }

  Future<void> update() async {
    CategoryModel.obyektlar[id] = this;
    await service.update(toJson(), where: "id='$id'");
  }
}

class CategoryService extends CrudService {
  @override
  CategoryService({super.prefix = ''}) : super('createCategoryTable');

  static String createCategoryTable = """
  CREATE TABLE "createCategoryTable" (
  "id" INTEGER NOT NULL DEFAULT 0,
  "nomi" TEXT NOT NULL DEFAULT '',
  PRIMARY KEY("id" AUTOINCREMENT)
  );
  """;

  @override
  Future<void> delete({String? where}) async {
    where = where == null ? "" : "WHERE $where";
    await db.query("DELETE FROM $table $where");
    debugPrint('CategoryService "delete" methodi ishladi');
  }

  @override
  Future<int> insert(Map map) async {
    map['id'] = (map['id'] == 0) ? null : map['id'];
    var insertId = await db.insert(map as Map<String, dynamic>, table);
    debugPrint('CategoryService "insert" methodi ishladi');
    return insertId;
  }

  @override
  Future<Map> select({String? where}) async {
    where = where == null ? "" : "WHERE $where";
    Map<int, dynamic> map = {};
    await for (final rows
        in db.watch("SELECT * FROM $table $where", tables: [table])) {
      for (final element in rows) {
        map[element['id']] = element;
      }
      return map;
    }
    debugPrint('CategoryService "select" methodi ishladi');
    return map;
  }

  @override
  Future<void> update(Map map, {String? where})async {
    where = where == null ? "" : " WHERE $where";

    String updateClause = "";
    final List params = [];
    final values = map.keys; //.where((element) => !keys.contains(element));
    for (String value in values) {
      if (updateClause.isNotEmpty) updateClause += ", ";
      updateClause += "$value=?";
      params.add(map[value]);
    }

    final String sql = "UPDATE $table SET $updateClause$where";
    await db.execute(sql, tables: [table], params: params);
    debugPrint('CategoryService "update" methodi ishladi');

  }
}
