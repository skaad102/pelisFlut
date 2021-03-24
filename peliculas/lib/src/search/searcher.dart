import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculaModels.dart';
import 'package:peliculas/src/providers/peliculasProviders.dart';

class DataSercher extends SearchDelegate {
  final _peliculas = ['Casa'];

  final _resientes = ['Casa'];

  final peliculasProviders = PeliculasProviders();

  @override
  String get searchFieldLabel => "Buscar Pelicula";

  @override
  List<Widget> buildActions(BuildContext context) {
    // crear acciones appbar
    return [
      IconButton(icon: Icon(Icons.clear_rounded), onPressed: () => {query = ''})
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // parte izquierda
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () => {close(context, null)});
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: peliculasProviders.getBusqueda(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          var peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((pelicula) {
              pelicula.peliculaUniq = '${pelicula.id}-serch';
              return ListTile(
                leading: Hero(
                  tag: pelicula.peliculaUniq,
                  child: FadeInImage(
                    image: NetworkImage(pelicula.getPoster()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList(),
          );
        } else {
          return Container(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    // final _listaSugerida = (query.isEmpty)
    //     ? _resientes
    //     : _peliculas.where((p) => p.toLoweCase().startsWith(query)).toList();
    // return ListView.builder(
    //   itemCount: _peliculas.length,
    //   itemBuilder: (context, i) {
    //     return ListTile(
    //       leading: Icon(Icons.movie_creation_outlined),
    //       title: Text(_peliculas[i].toString()),
    //       onTap: () {},
    //     );
    //   },
    // );
  }
}
