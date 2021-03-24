class Peliculas {
  List<Pelicula> items = [];
  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      // mapear las peliculas recividas
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  String peliculaUniq;
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Pelicula({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    voteCount = json['vote_count'];
  }

  getPoster() {
    if (posterPath == null) {
      return 'https://cdn3.iconfinder.com/data/icons/glypho-photography/64/camera-not-allowed-no-photos-512.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }

  getBackground() {
    if (posterPath == null) {
      return 'https://cdn3.iconfinder.com/data/icons/glypho-photography/64/camera-not-allowed-no-photos-512.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$backdropPath';
  }
}
