import 'package:flutter/material.dart';
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
      body: Center(
        child: Text('Home Page'),
     ),
     bottomNavigationBar: CustomNavigationBar(),
     floatingActionButton: ScanButton(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   );
  }
}