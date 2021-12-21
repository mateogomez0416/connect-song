import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_snd/domain/models/chat.dart';

import 'package:get/get.dart';

// Controlador para el manejo del chat
class ControllerChat extends GetxController {
  final DatabaseReference _mensajesRef =
      FirebaseDatabase.instance.ref().child('mensajes');

  void guardarMensaje(Mensaje mensaje) {
    _mensajesRef.push().set(mensaje.toJson());
  }

  void actualizarMensaje(Map<String, dynamic> datosmod, String idmensaje) {
    _mensajesRef.child(idmensaje).update(datosmod);
  }

  void deleteMensaje(String idmensaje) {
    _mensajesRef.child(idmensaje).remove();
  }

  Query getMensajes() => _mensajesRef;
}
