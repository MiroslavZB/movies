import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/services/api.dart';

class UserController extends ChangeNotifier {
  List<Movie> movies = [];
  List<int> savedIndexes = [];
  List<String> genreSet = [];
  List<int> yearSet = [];
  final GetStorage _storage = GetStorage();
  String _key = '';

  Future<void> getMovies() async {
    final parsed = await Client.get();
    List<Movie> movies_ = [];
    if (parsed is List) {
      for (Map e in parsed) {
        movies_.add(Movie.fromJson(e));
      }
    }
    movies = movies_;
    genreSet = movies.expand((e) => e.genres).toSet().toList();
    yearSet = movies.where((e) => e.year != null).map((e) => e.year!).toSet().toList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  void setKey(String key) {
    _key = key;
    notifyListeners();
  }

  void fetch() {
    if (_storage.hasData(_key)) {
      savedIndexes = List<int>.from(_storage.read(_key));
    }
    notifyListeners();
  }

  void removeId(int id) {
    savedIndexes.remove(id);
    write();
    notifyListeners();
  }

  void addId(int id) {
    savedIndexes.add(id);
    write();
    notifyListeners();
  }

  void write() {
    _storage.write(_key, savedIndexes);
  }
}
