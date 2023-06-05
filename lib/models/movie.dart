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
  final String averageRating;
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
    this.averageRating = '',
    this.originalTitle = '',
    this.storyLine = '',
    this.actors = const [],
    this.imdbRating,
    this.posterUrl = '',
  });

  factory Movie.fromJson(Map json) {
    try {
      double avgRating = double.tryParse(json['averageRating'].toString()) ?? 0;
      if (avgRating == 0 && json['ratings'] is List && json['ratings'].isNotEmpty) {
        avgRating = json['ratings'].reduce((value, element) => value + element) / json['ratings'].length;
      }
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
        averageRating: avgRating.toStringAsFixed(1),
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

  DateTime? get date => DateTime.tryParse(releaseDate);
  Duration? get duration_ => parseDuration(duration);

  factory Movie.empty() {
    return Movie(id: 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'genres': genres,
      'contentRating': contentRating,
      'averageRating': averageRating,
      'originalTitle': originalTitle,
      'storyLine': storyLine,
      'actors': actors,
      'imdbRating': imdbRating,
    };
  }

  @override
  toString() => toJson().toString();

  Duration? parseDuration(String durationString) {
    RegExp regex = RegExp(r'PT(\d+)M');
    RegExpMatch? match = regex.firstMatch(durationString);

    if (match != null && match.groupCount >= 1) {
      String? minutesString = match.group(1);
      if (minutesString == null) return null;
      int minutes = int.parse(minutesString);
      return Duration(minutes: minutes);
    }

    return null; // Invalid duration format
  }
}
