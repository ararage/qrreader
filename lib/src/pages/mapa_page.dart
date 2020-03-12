import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  final map = new MapController();

  @override
  Widget build(BuildContext context) {
    final ScanModel scanModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(scanModel.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(scanModel),
    );
  }

  Widget _crearFlutterMap( ScanModel scan ) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores( scan )
      ],
    );
  }

  TileLayerOptions _crearMapa(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiYXJhcmFnZSIsImEiOiJjazdvNzdmeGQwNnY5M2VwYnlrb2NvZWl3In0.BnXmKNux9w5E1MCM7R00Lg',
        'id': 'mapbox.streets' 
        // streets, dark, light, outdoors, satellite
      }
    ); 
  }

  MarkerLayerOptions _crearMarcadores( ScanModel scan ) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 120.0,
          height: 120.0,
          point: scan.getLatLng(),
          builder: ( context ) => Container(
            child: Icon( 
              Icons.location_on, 
              size: 50.0,
              color: Theme.of(context).primaryColor,
              ),
          )
        )
      ]
    );
  }
}