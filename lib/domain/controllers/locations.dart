import 'package:get/get.dart';
import 'package:location/location.dart';

// Controlador encargado de la ubicacion
class ControllerUbicacion extends GetxController {
  late Rx<dynamic> _posicionlat = "".obs;
  late Rx<dynamic> _posicionlo = "".obs;
  late Rx<dynamic> _cercanos = "0".obs;

  String get locationlat => _posicionlat.value;
  String get locationlo => _posicionlo.value;
  String get cercanos => _cercanos.value;

  Future<void> obtenerubicacion() async {
    late LocationData _posicion;
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _posicion = await location.getLocation();

    print('Posicion:-> ' + _posicion.toString());
    _posicionlat.value = _posicion.latitude.toString();
    _posicionlo.value = _posicion.longitude.toString();
  }

  set cercanos(String cercanos) {
    _cercanos.value = cercanos;
  }
}
