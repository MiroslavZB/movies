import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends ChangeNotifier {
  List<int> savedIndexes = [];
  final GetStorage _storage = GetStorage();
  String _key = '';

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
