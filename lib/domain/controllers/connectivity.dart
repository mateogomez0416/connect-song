import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

// Controlador para la verificacion de la conexion
class ConnectivityController extends GetxController {
  // Observables
  final _connected = false.obs;

  set connectivity(ConnectivityResult connectivity) {
    _connected.value = connectivity != ConnectivityResult.none;
  }

  // Getters
  bool get connected => _connected.value;
}
