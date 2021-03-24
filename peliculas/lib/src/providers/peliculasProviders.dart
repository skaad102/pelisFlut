import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:peliculas/src/models/castModels.dart';
import 'package:peliculas/src/models/peliculaModels.dart';
import 'package:http/http.dart' as http;

class PeliculasProviders {
  String _apiKey = 'dbf8fb743bf8cb6092b9e1796c9d97ad';
  String _url = 'api.themoviedb.org';
  String _lenguage = 'es-ES';
  int _popularesPage = 0;

  bool _cargando = false;

  List<Pelicula> _populares = [];

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  // decalrarlos solo una vez para el que los neesite

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStream() {
    // si esxiste cierralo
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _gerResp(Uri url) async {
    final resp = await http.get(url);

    final decodeData = json.decode(resp.body);

    final peliculas = Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'lenguage': _lenguage});

    return await _gerResp(url);
  }

  Future<List<Pelicula>> getPupulares() async {
    // print('object');
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'lenguage': _lenguage,
      'page': _popularesPage.toString()
    });

    final resp = await _gerResp(url);

    _populares.addAll(resp);

    popularesSink(_populares);

    _cargando = false;

    return resp;
  }

  Future<List<Actor>> getActores(String idActor) async {
    final url = Uri.https(_url, '3/movie/$idActor/credits',
        {'api_key': _apiKey, 'lenguage': _lenguage});

    final resp = await http.get(url);

    final decoData = jsonDecode(resp.body);

    final cast = Cast.fromJsonList(decoData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> getBusqueda(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'lenguage': _lenguage, 'query': query});

    return await _gerResp(url);
  }
}
