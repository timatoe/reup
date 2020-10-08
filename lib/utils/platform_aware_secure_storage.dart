import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' show Storage;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

class PlatformAwareSecureStorage {
  final FlutterSecureStorage mobileSecureStorage;
  final Storage webLocalStorage;

  PlatformAwareSecureStorage(this.mobileSecureStorage, this.webLocalStorage)
      : assert(mobileSecureStorage != null, webLocalStorage != null);

  Future<void> write({@required String key, @required String value}) async {
    if (kIsWeb) {
      webLocalStorage.addEntries([
        MapEntry(key, value),
      ]);
    } else {
      mobileSecureStorage.write(key: key, value: value);
    }
  }

  Future<String> read({@required String key}) async {
    if (kIsWeb) {
      return webLocalStorage[key];
    } else {
      return mobileSecureStorage.read(key: key);
    }
  }

  Future<void> delete({@required String key}) async {
    if (kIsWeb) {
      webLocalStorage.remove(key);
    } else {
      mobileSecureStorage.delete(key: key);
    }
  }
}
