

import 'package:hive/hive.dart';

class HiveCacheService {
  final String boxName;
  Box? _box;

  HiveCacheService({this.boxName = 'preproc_cache'});

  Future<void> open() async {
    if (_box != null && _box!.isOpen) return;
    _box = await Hive.openBox(boxName);
  }

  Future<void> put(String key, dynamic value) async {
    await open();
    await _box!.put(key, value);
  }

  Future<T?> get<T>(String key) async {
    await open();
    final v = _box!.get(key);
    if (v == null) return null;
    return v as T;
  }

  Future<void> delete(String key) async {
    await open();
    await _box!.delete(key);
  }
}