import 'package:flutter/cupertino.dart';
import 'package:qrreader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async
{
  final url = scan.valor;

  if(scan.tipo == 'http')
  {
    // Abrimos la web
    if(await canLaunch(url))
    {
      await launch(url);
    }else{
      throw 'Could not launch';
    }
  }else{
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }

}