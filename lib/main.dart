import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snd/domain/controllers/authentications.dart';
import 'package:flutter_snd/domain/controllers/chatrealtime.dart';
import 'package:flutter_snd/domain/controllers/connectivity.dart';
import 'package:flutter_snd/domain/controllers/firestore.dart';
import 'package:flutter_snd/domain/controllers/locations.dart';
import 'package:flutter_snd/domain/controllers/themecontroller.dart';
import 'package:flutter_snd/ui/app.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(
    updatePositionInBackground,
    isInDebugMode: true,
  );
  await Firebase.initializeApp();
  Get.put(ControllerChat());
  Get.put(ControllerFirestore());
  Get.put(ControllerAuth());
  Get.put(ThemeController());
  Get.put(ControllerUbicacion());
  // Connectivity Controller
  ConnectivityController connectivityController =
      Get.put(ConnectivityController());
  // Connectivity stream
  Connectivity().onConnectivityChanged.listen((connectivityStatus) {
    connectivityController.connectivity = connectivityStatus;
  });

  runApp(MyApp());
}

void updatePositionInBackground() async {
  Workmanager().executeTask((task, inputData) async {
    ControllerUbicacion controlubicacion = Get.find();
    controlubicacion.obtenerubicacion();
    return Future.value(true);
  });
}
