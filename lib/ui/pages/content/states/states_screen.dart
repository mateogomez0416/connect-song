import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_snd/domain/controllers/authentications.dart';
import 'package:flutter_snd/domain/controllers/firestore.dart';
import 'package:flutter_snd/ui/pages/content/music/card_plane.dart';
import 'package:flutter_snd/ui/pages/content/states/widgets/add_states.dart';
import 'package:flutter_snd/ui/pages/content/states/widgets/edit_states.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

// Widget que permite la creacion, edicion y visualizacion de estados
class ListaEstados extends StatefulWidget {
  @override
  _ListaEstadosState createState() => _ListaEstadosState();
}

class _ListaEstadosState extends State<ListaEstados> {
  ControllerFirestore controlp = Get.find();
  ControllerAuth controluser = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getInfo(context, controlp.readItems(), controluser.uid),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AgregarEstado());
        },
        tooltip: 'Refrescar',
        child: FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

@override
Widget getInfo(BuildContext context, Stream<QuerySnapshot> ct, String uid) {
  return StreamBuilder(
    stream: ct,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      print(snapshot.connectionState);
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator(),
          );

        case ConnectionState.active:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? VistaEstados(estados: snapshot.data!.docs, uid: uid)
              : Text('Sin Datos');

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}

@override
List<CardPlanetData> ConvertirData(BuildContext context, List estados) {
  final List<CardPlanetData> data_estados = [];
  var backgroundColor = const Color.fromRGBO(0, 10, 56, 1);
  var titleColor = Colors.pink;
  var subtitleColor = Colors.white;

  for (var i = 0; i < estados.length; i++) {
    data_estados.add(CardPlanetData(
      title: estados[i]['titulo'],
      name: estados[i]['name'],
      picUrl: NetworkImage(estados[i]['photo']),
      subtitle: estados[i]['detalle'],
      image: NetworkImage(estados[i]['fotoestado']),
      backgroundColor: backgroundColor,
      titleColor: titleColor,
      subtitleColor: subtitleColor,
      background: LottieBuilder.asset("assets/animation/music-pattern.json"),
    ));
    if (i % 2 == 0) {
      backgroundColor = Colors.white;
      titleColor = Colors.purple;
      subtitleColor = const Color.fromRGBO(0, 10, 56, 1);
    } else {
      backgroundColor = const Color.fromRGBO(0, 10, 56, 1);
      titleColor = Colors.pink;
      subtitleColor = Colors.white;
    }
  }
  return data_estados;
}

class VistaEstados extends StatelessWidget {
  final List estados;
  final String uid;

  const VistaEstados({required this.estados, required this.uid});

  @override
  Widget build(BuildContext context) {
    final data = ConvertirData(context, estados);
    print("object");
    print(data);
    print(data[0].backgroundColor);

    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index, double value) {
          return CardPlanet(data: data[index]);
        },
      ),
    );
  }
}
