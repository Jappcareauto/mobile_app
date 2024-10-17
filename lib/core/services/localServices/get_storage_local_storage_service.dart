import 'package:get_storage/get_storage.dart';
import 'local_storage_service.dart';

class GetStorageService implements LocalStorageService {
  final GetStorage storage = GetStorage();

  @override
  Future<void> write(String key, dynamic value) async {
    await storage.write(key, value);
  }

  @override
  dynamic read(String key) {
    return storage.read(key);
  }

  @override
  Future<void> delete(String key) async {
    await storage.remove(key);
  }
}