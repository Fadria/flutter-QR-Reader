import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/utils/utils.dart';

class ScanTiles extends StatelessWidget {

  final String tipo;

  const ScanTiles({required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: true); // Dentro de un build lo usaremos en true
    final scans = scanListProvider.scans;

    return ListView.builder
    (
      itemBuilder: (_, i) => ListTile
        (
          leading: 
          Icon
          (
            this.tipo == 'http' ? Icons.screen_search_desktop_outlined : Icons.location_on, 
            color: Theme.of(context).primaryColor
          ),
          title: Text(scans[i].valor),
          subtitle: Text(scans[i].id.toString()),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => launchURL(context, scans[i]),
        ),
      itemCount: scans.length);
  }
}