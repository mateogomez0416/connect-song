import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_snd/domain/controllers/authentications.dart';
import 'package:flutter_snd/domain/controllers/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// Widget que permite mostrar publicidad en la aplicacion. Esta informacion
// debe ser cargada directamente en firebase.
// [publicidad] => {cel: "3003013012", detalle: "Play Station 4 en muy buen estado",
//                  imagen: "https://i.ytimg.com/vi/_WMY5rNQ1Zc/maxresdefault.jpg",
//                  wp: "+573003013011"}
class Listapublicidad extends StatefulWidget {
  @override
  _ListapublicidadState createState() => _ListapublicidadState();
}

class _ListapublicidadState extends State<Listapublicidad> {
  ControllerFirestore controlp = Get.find();
  ControllerAuth controluser = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getInfo(context, controlp.readpublicidad(), controluser.uid),
    );
  }
}

@override
Widget getInfo(BuildContext context, Stream<QuerySnapshot> ct, String uid) {
  return StreamBuilder(
    stream: ct,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.active:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? VistaPublicidad(publicidad: snapshot.data!.docs, uid: uid)
              : Text('Sin Datos');

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}

class VistaPublicidad extends StatelessWidget {
  final List publicidad;
  final String uid;
  const VistaPublicidad({required this.publicidad, required this.uid});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: publicidad.length == 0 ? 0 : publicidad.length,
        itemBuilder: (context, posicion) {
          return Card(
            elevation: 2,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 16.0, left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: (publicidad[posicion]['imagen'] != '')
                        ? Image.network(publicidad[posicion]['imagen'])
                        : Text(''),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await launch('tel://${publicidad[posicion]['cel']}');
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.mobileAlt,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          var url = "whatsapp://send?phone=" +
                              publicidad[posicion]['wp'] +
                              "&text=Hola Estoy Interesado";
                          await launch(url);
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.red,
                        ),
                      ),
                      Text((publicidad[posicion]['detalle']))
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
