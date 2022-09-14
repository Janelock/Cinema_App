class MovieModel{
  String id;
  String title;
  String genre;
  num rating;
  String runtime;
  String storyLine;
  String? image;

  MovieModel ({
    required this.id,
    required this.genre,
    required this.title,
    required this.rating,
    required this.runtime,
    required this.storyLine,
    this.image
  });

  factory MovieModel.fromJson(dynamic json) {
    return MovieModel(
        id: json['id'] as String,
        genre: json['genres'][0] as String,
        title: json['title'] as String,
        rating: json['rating'] as num,
        runtime: json['runtime'] as String,
        storyLine: json['description'] as String,
    );
  }

  static MovieModel moviesFromSnapshot(Map snapshot) {

    return MovieModel.fromJson(snapshot);

  }
}