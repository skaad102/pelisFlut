import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/peliculaModels.dart';

class SwiperCard extends StatelessWidget {
  final List<Pelicula> peliculas;
  const SwiperCard({Key key, @required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].peliculaUniq = '${peliculas[index].id}-swipwe';
          return Hero(
            tag: peliculas[index].peliculaUniq,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detalle',
                      arguments: peliculas[index]),
                  child: FadeInImage(
                    image: NetworkImage(peliculas[index].getPoster()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fadeInCurve: Curves.bounceIn,
                    fit: BoxFit.cover,
                  ),
                )),
          );
        },
        itemCount: peliculas.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        // pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }
}
