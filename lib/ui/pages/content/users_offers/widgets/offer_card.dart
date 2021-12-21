import 'package:flutter/material.dart';
import 'package:flutter_snd/ui/widgets/card.dart';

class PostCard extends StatelessWidget {
  final String nombre, artista, album, duracion;
  

  // PostCard constructor
  const PostCard(
      {Key? key,
      required this.nombre,
      required this.album,
      required this.artista,
      required this.duracion})
      : super(key: key);

  // We create a Stateless widget that contais an AppCard,
  // Passing all the customizable views as parameters
  @override
  Widget build(BuildContext context) {
    
    return AppCard(
      key: const Key("socialCard"),
      title: nombre,
      content: Text(
        album,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      // topLeftWidget widget as an Avatar
      topLeftWidget: Text(
        artista,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      // topRightWidget widget as an IconButton
      topRightWidget: Text(
        duracion,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      
    );
  }
}
