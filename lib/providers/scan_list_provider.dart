import 'package:flutter/material.dart';
import 'package:qrreader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier
{
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  nuevoScan(String valor) async
  {
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    nuevoScan.id = id;

    if(this.tipoSeleccionado == nuevoScan.tipo)
    {
      this.scans.add(nuevoScan);
      notifyListeners();
    }

  }
}