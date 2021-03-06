import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrreader/providers/db_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget 
{

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> 
{

  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) 
  {
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17.5,
    );

    // Marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(markerId: MarkerId('geo-location'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar
      (
        title: Text('Mapa'),
        actions: 
        [
          IconButton
          (
            icon: Icon(Icons.location_searching), 
            onPressed: () async
            {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition
              (
                CameraPosition
                (
                  target: scan.getLatLng(),
                  zoom: 17.5
                ),
              ));
            })          
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Padding
      (
        padding: const EdgeInsets.only(right: 50.0),
        child: FloatingActionButton
        (
          onPressed: ()
          {
            if(mapType == MapType.normal)
            {
              mapType = MapType.satellite;
            }else{
              mapType = MapType.normal;
            }
      
            setState((){});
          },
          child: Icon(Icons.layers),
        ),
      ),
   );
  }
}