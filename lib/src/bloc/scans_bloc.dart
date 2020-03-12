import 'dart:async';

import 'package:qrreaderapp/src/providers/db_provider.dart';

class ScansBloc {
  
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    // Obtener Scans de la base de datos
  }

  final _scanController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scanController.stream;

  dispose(){
    _scanController?.close();
  }

  getScans() async{
    _scanController.sink.add(await DBProvider.db.getTodosScans());
  }

  addScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    getScans();
  }

  deleteScan(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAll();
    getScans();
  }

}