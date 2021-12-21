import 'package:flutter/material.dart';
import 'package:flutter_snd/domain/controllers/authentications.dart';
import 'package:flutter_snd/domain/controllers/chatrealtime.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Widget que me permite construir los detalles de cada mensaje
class MensajeWidget extends StatelessWidget {
  final String texto;
  final DateTime fecha;
  final String name;
  final String idmensaje;
  final String uid;
  final String photo;
  final String email;
  MensajeWidget(this.texto, this.fecha, this.name, this.idmensaje, this.uid,
      this.photo, this.email);

  @override
  Widget build(BuildContext context) {
    ControllerChat controlchat = Get.find();
    ControllerAuth controluser = Get.find();
    return Padding(
      padding: const EdgeInsets.only(left: 1, top: 5, right: 1, bottom: 2),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(photo),
            ),
            title: Text(email),
            subtitle: Text(name),
            trailing: Text(DateFormat('kk:mma').format(fecha).toString()),
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey[350]!,
                  blurRadius: 2.0,
                  offset: Offset(0, 1.0))
            ], borderRadius: BorderRadius.circular(50.0), color: Colors.white),
            child: MaterialButton(
              disabledTextColor: Colors.black87,
              padding: EdgeInsets.only(left: 18),
              onPressed: null,
              onLongPress: () {
                if (controluser.uid == uid) {
                  controlchat.deleteMensaje(idmensaje);
                }
              },
              child: Wrap(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: (controluser.uid == uid)
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Text(texto),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                DateFormat('dd-MM-yyyyy').format(fecha).toString(),
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
