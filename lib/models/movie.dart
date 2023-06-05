class Movie {
  final int id;
  final String title;
  final int? year;
  final List<String> genres;
  final List<int> ratings;
  final String poster;
  final int? contentRating;
  final String duration;
  final String releaseDate;
  final int averageRating;
  final String originalTitle;
  final String storyLine;
  final List<String> actors;
  final int? imdbRating;
  final String posterUrl; // written as posterurl in function

  Movie({
    required this.id,
    this.title = '',
    this.year,
    this.genres = const [],
    this.ratings = const [],
    this.poster = '',
    this.contentRating,
    this.duration = '',
    this.releaseDate = '',
    this.averageRating = 0,
    this.originalTitle = '',
    this.storyLine = '',
    this.actors = const [],
    this.imdbRating,
    this.posterUrl = '',
  });

  factory Movie.fromJson(Map json) {
    try {
      return Movie(
        id: int.parse(json['id']),
        title: json['title'],
        year: int.tryParse(json['year'].toString()),
        genres: (json['genres'] as List).map((e) => e.toString()).toList(),
        ratings: (json['ratings'] as List).map((e) => int.tryParse(e.toString()) ?? 0).toList(),
        poster: json['poster'],
        contentRating: int.tryParse(json['contentRating'].toString()),
        duration: json['duration'],
        releaseDate: json['releaseDate'],
        averageRating: json['averageRating'],
        originalTitle: json['originalTitle'],
        storyLine: json['storyLine'] ?? '',
        actors: (json['actors'] as List).map((e) => e.toString()).toList(),
        imdbRating: int.tryParse(json['imdbRating'].toString()),
        posterUrl: json['posterurl'], // written as posterurl in function
      );
    } catch (_, __) {
      return Movie.empty();
    }
  }

  factory Movie.empty() {
    return Movie(id: 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'genres': genres,
      'ratings': ratings,
      'poster': poster,
      'contentRating': contentRating,
      'duration': duration,
      'releaseDate': releaseDate,
      'averageRating': averageRating,
      'originalTitle': originalTitle,
      'storyLine': storyLine,
      'actors': actors,
      'imdbRating': imdbRating,
      'posterurl': posterUrl,
    };
  }

  @override
  toString() => toJson().toString();
}
