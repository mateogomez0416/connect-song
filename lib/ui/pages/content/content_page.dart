import 'package:flutter/material.dart';
import 'package:flutter_snd/domain/controllers/authentications.dart';
import 'package:flutter_snd/domain/controllers/connectivity.dart';
import 'package:flutter_snd/domain/controllers/themecontroller.dart';
import 'package:flutter_snd/ui/pages/content/chat/chat_screen.dart';
import 'package:flutter_snd/ui/pages/content/locations/locations_screen.dart';
import 'package:flutter_snd/ui/pages/content/public_offers/public_offers_screen.dart';
import 'package:flutter_snd/ui/pages/content/states/states_screen.dart';
import 'package:get/get.dart';

import 'home/homePage.dart';
import 'music/screens/response_screen.dart';

// Widget con el contenido de la aplicacion
class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ControllerAuth controluser = Get.find();
    ThemeController controltema = Get.find();
    ConnectivityController connectivityController =
        Get.find<ConnectivityController>();

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                controltema.selecciontema();
              },
              icon: Obx(
                () => Icon(
                  (controltema.themedark)
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                await controluser.logOut();
                Get.offAllNamed('/auth');
              },
              icon: Icon(Icons.exit_to_app_rounded),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.music_note),
              ),
              Tab(
                icon: Icon(Icons.work),
              ),
              Tab(
                icon: Icon(Icons.gps_fixed),
              ),
              Tab(
                icon: Icon(Icons.chat_bubble),
              ),
            ],
          ),
          title: Text('Connect Song'),
        ),
        body: TabBarView(
          children: [
            Obx(
              () => (connectivityController.connected)
                  ? ListaEstados()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
            Obx(
              () => (connectivityController.connected)
                  ? HomePage()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
            Obx(
              () => (connectivityController.connected)
                  ? ResponseScreen()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
            Obx(
              () => (connectivityController.connected)
                  ? Locations()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
            Obx(
              () => (connectivityController.connected)
                  ? ListaMensajes()
                  : Center(
                      child: Icon(Icons.wifi_off),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
