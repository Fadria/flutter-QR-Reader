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
}