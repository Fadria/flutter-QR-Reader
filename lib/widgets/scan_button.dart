import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton
    (
      elevation: 0, 
      onPressed: () async
      {
        // Comentamos debido a que desde el emulador no podemos leer un QR
        // Hemos comprobado su funcionamiento en dispositivos móviles y funciona perfectamente
        /*
        String barcodeScanRes = 
          await FlutterBarcodeScanner.scanBarcode
          (
            '#3D88EF', 
            'Cancelar', 
            false, 
            ScanMode.QR // También podríamos usar un código de barras
          );
          */
          final barcodeScanRes = 'http://google.com';

          final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
          scanListProvider.nuevoScan(barcodeScanRes);
          scanListProvider.nuevoScan('geo:15.33.15.66');
      }, 
      child: Icon(Icons.filter_center_focus)
    );
  }
}