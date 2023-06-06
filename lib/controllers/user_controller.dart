import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/services/api.dart';
import 'package:movies/services/database.dart';

class UserController extends ChangeNotifier {
  List<Movie> movies = [];
  List<int> savedIndexes = [];
  List<String> genreSet = [];
  List<int> yearSet = [];
  final GetStorage _storage = GetStorage();
  String _key = '';
  String _email = '';

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

  void fetch() {
    if (_key.isNotEmpty) {
      fetchStorage();
    } else {
      fetchRemote();
    }
  }

  void removeId(int id) {
    savedIndexes.remove(id);
    if (_key.isNotEmpty) {
      removeIdStorage(id);
    } else {
      writeRemote();
    }
    notifyListeners();
  }

  void addId(int id) {
    savedIndexes.add(id);
    if (_key.isNotEmpty) {
      addIdStorage(id);
    } else {
      writeRemote();
    }
    notifyListeners();
  }

  // Guest User Functions
  void setKey(String key) {
    _key = key;
  }

  void fetchStorage() {
    if (_storage.hasData(_key)) {
      savedIndexes = List<int>.from(_storage.read(_key));
    }
    notifyListeners();
  }

  void removeIdStorage(int id) {
    write();
    notifyListeners();
  }

  void addIdStorage(int id) {
    write();
    notifyListeners();
  }

  void write() {
    _storage.write(_key, savedIndexes);
  }

  // Authenticated User Functions
  void setEmail(String email) {
    _email = email;
  }

  Future<void> fetchRemote() async {
    final tempList = await Database.readUser(_email);
    savedIndexes = tempList.map((e) => int.parse(e.toString())).toList();
    notifyListeners();
  }

  Future<void> writeRemote() async {
    Database.postUser(savedIndexes, _email);
  }
}
