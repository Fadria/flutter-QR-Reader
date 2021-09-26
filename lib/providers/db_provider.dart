import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qrreader/models/scan_model.dart';
export 'package:qrreader/models/scan_model.dart';

class DBProvider
{
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async
  {
    if(_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async
  {
    // Path base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    // Creamos la base de datos
    return await openDatabase
    (
      path, 
      version: 1, // Debemos aumentar la versión cuando editemos las tablas para volver a recargarlas
      onOpen: (db){},
      onCreate: (Database db, int version) async
      {
        await db.execute('''
          CREATE TABLE Scans
          (
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      }
    );
  }
  
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async
  {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;
    
    // Verificar la base de datos
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
      VALUES($id, '$tipo', '$valor')
    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async
  {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    print(res);

    // ID del último registro insertado
    return res;
  }

  Future<ScanModel?> getScanById(int id) async
  {
    final db = await database;

    // Los interrogantes corresponden a los valores de whereArgs de izquierda a derecha
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty? ScanModel.fromJson(res.first): null;
  }

  Future<List<ScanModel>> getTodosLosScans() async
  {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty?res.map((e) => ScanModel.fromJson(e)).toList():[];
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async
  {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty?res.map((e) => ScanModel.fromJson(e)).toList():[];
  }

  Future<int> updateScan(ScanModel nuevoScan) async
  {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  Future<int> deleteScan(int id) async
  {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> deleteAllScans() async
  {
    final db = await database;
    
    // Forma 1
    final res = await db.delete('Scans');

    // Forma 2 - Más sencilla cuando necesitamos usar joins, podemos copiar la consulta de nuestro SGBD
    /*final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');*/

    return res;
  }
}