import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';


class MapasPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: true); // Dentro de un build lo usaremos en true
    final scans = scanListProvider.scans;

    return ListView.builder
    (
      itemBuilder: (_, i) => ListTile
        (
          leading: Icon(Icons.location_on, color: Theme.of(context).primaryColor),
          title: Text(scans[i].valor),
          subtitle: Text(scans[i].id.toString()),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => print(scans[i].id),
        ),
      itemCount: scans.length);
  }
}