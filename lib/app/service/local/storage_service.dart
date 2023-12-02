import 'package:get_storage/get_storage.dart';

class StorageServices {
  var box = GetStorage();

  final String _isLoggedKey = "isLogged";

  
  Future<void> setIsLogged(bool status) async {
    box.write(_isLoggedKey, status);
  }

  Future<bool> getIsLogged() async {
    bool status = box.read(_isLoggedKey) ?? false;
    return status;
  }
  
  Future<void> clearUserData() async {
    box.write(_isLoggedKey, false);
  }
}
