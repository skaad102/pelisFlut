import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculasProviders.dart';
import 'package:peliculas/src/search/searcher.dart';
import 'package:peliculas/src/widgets/hrizontalWidget.dart';
import 'package:peliculas/src/widgets/swiperWidget.dart';

class HomePage extends StatelessWidget {
  final pelicualPrivide = PeliculasProviders();

  HomePage({Key key, pelicualPrivide});

  @override
  Widget build(BuildContext context) {
    pelicualPrivide.getPupulares();
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSercher());
            },
          )
        ],
      ),
      body: SafeArea(
          child: Container(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _peliculas(),
          _listPeliculas(context),
        ],
      ))),
    );
  }

  //swiper de las peliculas
  Widget _peliculas() {
    return FutureBuilder(
      future: pelicualPrivide.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return SwiperCard(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
    //;
    //
  }

  //lista horizontal peliculas
  Widget _listPeliculas(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //lista
          StreamBuilder(
            stream: pelicualPrivide.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: MovieHorizontal(
                    peliculas: snapshot.data,
                    nextPage: pelicualPrivide.getPupulares,
                  ),
                );
              } else {
                return Container(
                  height: 30,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
