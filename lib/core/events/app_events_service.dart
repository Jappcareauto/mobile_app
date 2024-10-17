import 'package:get/get.dart';

class AppEventService extends GetxService {
  final _eventBus = <String, Rx<dynamic>>{};

  Rx<T> on<T>(String eventName) {
    _eventBus[eventName] ??= Rx<T?>(null);
    return _eventBus[eventName] as Rx<T>;
  }

  void emit<T>(String eventName, T data) {
    if (_eventBus[eventName] != null) {
      _eventBus[eventName]?.value = data;
    }
  }
}