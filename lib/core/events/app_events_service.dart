import 'package:get/get.dart';

class AppEventService extends GetxService {
  final Map<String, dynamic> _eventBus = {};

  Rxn<T> on<T>(String eventName) {
    if (!_eventBus.containsKey(eventName)) {
      _eventBus[eventName] = Rxn<T>();
    }
    return _eventBus[eventName] as Rxn<T>;
  }

  void emit<T>(String eventName, T data) {
    if (_eventBus.containsKey(eventName)) {
      (_eventBus[eventName] as Rxn<T>).value = data;
    } else {
      // Si l'événement n'existe pas encore, on l'initialise et on émet la valeur
      _eventBus[eventName] = Rxn<T>(data);
    }
  }

  T? getLastValue<T>(String eventName) {
    if (_eventBus.containsKey(eventName)) {
      return (_eventBus[eventName] as Rxn<T>).value;
    }
    return null;
  }
}
