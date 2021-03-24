import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:peliculas/src/models/castModels.dart';
import 'package:peliculas/src/models/peliculaModels.dart';
import 'package:peliculas/src/providers/peliculasProviders.dart';

class DetallePelicula extends StatelessWidget {
  const DetallePelicula({Key key});

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _appBar(pelicula),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            _postertottulo(pelicula, context),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _listaActores(pelicula),
          ]))
          // Container(
          //   padding: EdgeInsets.all(20),
          //   child: Text('holi'),
          // ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.arrow_back),
      //   onPressed: () => Navigator.pop(context),
      //   backgroundColor: Colors.deepPurpleAccent,
      // ),
    );
  }
}

Widget _appBar(Pelicula pelicula) {
  return SliverAppBar(
    elevation: 5.0,
    backgroundColor: Colors.deepPurpleAccent,
    expandedHeight: 200,
    pinned: true,
    floating: false,
    stretch: true,
    centerTitle: true,
    flexibleSpace: FlexibleSpaceBar(
      title: Text(pelicula.title),
      // centerTitle: false,
      background: FadeInImage(
        image: NetworkImage(pelicula.getBackground()),
        placeholder: AssetImage('assets/img/loading.gif'),
        fit: BoxFit.cover,
        fadeInDuration: Duration(milliseconds: 800),
        fadeInCurve: Curves.bounceIn,
      ),
    ),
  );
}

Widget _postertottulo(Pelicula pelicula, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Hero(
          tag: pelicula.peliculaUniq,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage(pelicula.getPoster()),
              height: 150,
            ),
          ),
        ),
        SizedBox(width: 20),
        Flexible(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              pelicula.title,
              style: Theme.of(context).textTheme.subtitle2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              pelicula.originalTitle,
              style: Theme.of(context).textTheme.bodyText2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.star_border),
                Text(pelicula.voteAverage.toString())
              ],
            )
          ],
        ))
      ],
    ),
  );
}

Widget _descripcion(Pelicula pelicula) {
  return Container(
    padding: EdgeInsets.symmetric(
      vertical: 15,
      horizontal: 12,
    ),
    child: Text(
      pelicula.overview,
      textAlign: TextAlign.justify,
    ),
  );
}

Widget _listaActores(Pelicula pelicula) {
  final peliculaProvider = PeliculasProviders();

  return FutureBuilder(
    future: peliculaProvider.getActores(pelicula.id.toString()),
    // initialData: InitialData,
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
      if (snapshot.hasData) {
        return _actoresPage(snapshot.data);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

Widget _actoresPage(List<Actor> data) {
  return SizedBox(
    height: 200,
    child: PageView.builder(
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        itemCount: data.length,
        itemBuilder: (context, i) {
          return _targetActor(data[i]);
        }),
  );
}

Widget _targetActor(Actor actor) {
  return Container(
    padding: EdgeInsets.only(right: 12),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: FadeInImage(
            image: NetworkImage(actor.getPhoto()),
            placeholder: AssetImage('assets/img/no-image.jpg'),
          ),
        ),
        Text(
          actor.name,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ),
  );
}
