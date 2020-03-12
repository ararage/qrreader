import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';

import 'package:qrreaderapp/src/models/scan_model.dart';

import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';

import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.deleteAllScans,
          )
        ],
      ),
      body: Center(
        child: _callPage(currentIndex),
      ),
      bottomNavigationBar: _crearBottomNavigatorBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () {
          _scanQR(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR(BuildContext context) async {
    String futureString = 'http://google.com';
    // Future String : geo:40.70380499375163,-74.01435270747074
    /*try{
      futureString = await BarcodeScanner.scan();
    }catch(e){
      futureString = e.toString();
    }*/
    print("Future String : $futureString");
    if (futureString != null) {
      final scan = ScanModel(valor: futureString);
      final scan2 = ScanModel(valor: 'geo:19.3541784,-99.0944171,13z');
      scansBloc.addScan(scan);
      scansBloc.addScan(scan2);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.openScan(context, scan);
        });
      } else {
        utils.openScan(context, scan);
      }
    }
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  Widget _crearBottomNavigatorBar() {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
          BottomNavigationBarItem(
              icon: Icon(Icons.brightness_5), title: Text('Direcciones'))
        ]);
  }
}
