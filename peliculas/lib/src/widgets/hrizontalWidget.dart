import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculaModels.dart';
import 'package:peliculas/src/pages/detallePage.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function nextPage;
  MovieHorizontal({Key key, @required this.peliculas, @required this.nextPage});

  final _pageControler = PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageControler.addListener(() {
      if (_pageControler.position.pixels >=
          _pageControler.position.maxScrollExtent - 200) {
        // print('pintar');
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        // physics: ScrollPhysics,
        controller: _pageControler,
        // children: _targetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _targetasBilder(context, peliculas[i]),
      ),
    );
  }

  // List<Widget> _targetas(BuildContext context) {
  //   return peliculas.map((p) {

  //   }).toList();
  // }

  Widget _targetasBilder(BuildContext context, Pelicula p) {
    p.peliculaUniq = '${p.id}-horiz';
    final targeta = Container(
      margin: EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Hero(
            tag: p.peliculaUniq,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                fadeInCurve: Curves.easeInCirc,
                image: NetworkImage(p.getPoster()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 145,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            p.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: targeta,
      onTap: () => Navigator.pushNamed(context, 'detalle', arguments: p),
    );
  }
}
