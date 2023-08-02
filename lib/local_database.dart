import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'features/todo/domain/entities/note_model.dart';

class NoteFields {
  static final List<String> values = [id, name, color, description, time, date];

  static const String id = 'id';
  static const String name = 'name';
  static const String color = 'color';
  static const String description = 'description';
  static const String time = 'time';
  static const String date = 'date';
}

const String tableName = 'notes';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();
  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('note.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableName (
  ${NoteFields.id} $idType,
  ${NoteFields.name} $textType,
  ${NoteFields.color} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.time} $textType,
  ${NoteFields.date} $textType
)
''');
  }

  Future<NoteModel> create(NoteModel note) async {
    final db = await instance.database;
    final id = await db.insert(tableName, note.toJson());
    return note.copy(id: id);
  }

  Future<NoteModel> read(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableName,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return NoteModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<NoteModel>> readAll() async {
    final db = await instance.database;

    const orderBy = '${NoteFields.date} DESC, ${NoteFields.time} DESC';

    final result = await db.query(tableName, orderBy: orderBy);

    return result.map((json) => NoteModel.fromJson(json)).toList();
  }

  Future<void> update(NoteModel note) async {
    final db = await instance.database;

    await db.update(
      tableName,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await instance.database;

    await db.delete(
      tableName,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    final db = await instance.database;

    await db.delete(tableName);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
