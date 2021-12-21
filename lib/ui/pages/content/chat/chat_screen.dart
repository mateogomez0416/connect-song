import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_snd/domain/controllers/authentications.dart';
import 'package:flutter_snd/domain/controllers/chatrealtime.dart';
import 'package:flutter_snd/domain/models/chat.dart';
import 'package:flutter_snd/ui/pages/content/chat/widgets/chat_details.dart';

import 'package:get/get.dart';

// Widget que permite la creacion, edicion y visualizacion de los mensajes
class ListaMensajes extends StatefulWidget {
  ListaMensajes({Key? key}) : super(key: key);

  @override
  ListaMensajesState createState() => ListaMensajesState();
}

class ListaMensajesState extends State<ListaMensajes> {
  ScrollController _scrollController = ScrollController();
  TextEditingController _mensajeController = TextEditingController();
  ControllerChat controlchat = Get.find();
  ControllerAuth controluser = Get.find();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollHaciaAbajo());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _getListaMensajes(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _mensajeController,
                      onChanged: (text) => setState(() {}),
                      onSubmitted: (input) {
                        _enviarMensaje();
                      },
                      decoration:
                          const InputDecoration(hintText: 'Escribe un mensaje'),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(_puedoEnviarMensaje()
                        ? CupertinoIcons.arrow_right_circle_fill
                        : CupertinoIcons.arrow_right_circle),
                    onPressed: () {
                      _enviarMensaje();
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _enviarMensaje() {
    if (_puedoEnviarMensaje()) {
      final mensaje = Mensaje(
          _mensajeController.text,
          DateTime.now(),
          controluser.name,
          controluser.uid,
          controluser.photo,
          controluser.emailf);
      controlchat.guardarMensaje(mensaje);
      _mensajeController.clear();
      setState(() {});
    }
  }

  bool _puedoEnviarMensaje() => _mensajeController.text.length > 0;

  Widget _getListaMensajes() {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: controlchat.getMensajes(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          print('Id_unico:${snapshot.key}');
          var idmensaje = snapshot.key;
          final mensaje = Mensaje.fromJson(json);
          return MensajeWidget(mensaje.texto, mensaje.fecha, mensaje.name,
              idmensaje!, mensaje.uid, mensaje.photo, mensaje.email);
        },
      ),
    );
  }

  void _scrollHaciaAbajo() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }
}
