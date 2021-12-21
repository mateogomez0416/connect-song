class Mensaje {
  final String texto;
  final DateTime fecha;
  final String name;
  final String uid;
  final String photo;
  final String email;

  Mensaje(this.texto, this.fecha, this.name, this.uid, this.photo, this.email);

  Mensaje.fromJson(Map<dynamic, dynamic> json)
      : fecha = DateTime.parse(json['fecha'] as String),
        texto = json['texto'] as String,
        name = json['name'] as String,
        uid = json['uid'] as String,
        photo = json['photo'] as String,
        email = json['email'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'fecha': fecha.toString(),
        'texto': texto,
        'name': name,
        'uid': uid,
        'photo': photo,
        'email': email,
      };
}
