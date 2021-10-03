import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/utils/utils.dart';

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
          final barcodeScanRes = 'geo:40.07037605499038,-2.137388990500356';

          if(barcodeScanRes == '-1') return;

          final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
          final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

          launchURL(context, nuevoScan);
      }, 
      child: Icon(Icons.filter_center_focus)
    );
  }
}