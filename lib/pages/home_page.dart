import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/pages/direcciones_page.dart';
import 'package:qrreader/pages/mapas_page.dart';
import 'package:qrreader/providers/db_provider.dart';
import 'package:qrreader/providers/ui_provider.dart';
import 'package:qrreader/widgets/custom_navigatorbar.dart';
import 'package:qrreader/widgets/scan_button.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar
      (
        elevation: 0,
        title: Text('Historial'),
        actions: 
        [
          IconButton(onPressed: (){}, icon: Icon(Icons.delete_forever))
        ],
      ),
      body: _HomePageBody(),

     bottomNavigationBar: CustomNavigationBar(),
     floatingActionButton: ScanButton(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   );
  }
}

class _HomePageBody extends StatelessWidget {
 @override
  Widget build(BuildContext context) 
  {
    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    // Cambiar para mostrar la página respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    // TO DO: Temporalmente leer la base de datos
    final tempScan = new ScanModel(valor: 'http://google.es');
    DBProvider.db.nuevoScan(tempScan);

    switch (currentIndex) 
    {
      case 0:
        return MapasPage();

      case 1:
        return DireccionesPage();

      default:
        return MapasPage();
    }
  }
}