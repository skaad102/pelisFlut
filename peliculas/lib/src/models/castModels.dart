class Cast {
  List<Actor> actores = [];
  Cast();
  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    // recorrer

    //   for (var item in jsonList) {
    //   // mapear las peliculas recividas
    //   final actor = new Actor.fromJsonMap(item);
    //   actores.add(actor);
    // }

    jsonList.forEach((element) {
      final actor = new Actor.fromJsonMap(element);
      actores.add(actor);
    });
  }
}

class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int actorId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.actorId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    actorId = json['actor_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    department = json['department'];
    job = json['job'];
  }

  getPhoto() {
    if (profilePath == null) {
      return 'https://www.slotcharter.net/wp-content/uploads/2020/02/no-avatar.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}
