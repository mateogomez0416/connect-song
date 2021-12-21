import 'package:flutter/material.dart';
import 'package:flutter_snd/data/services/track_pool.dart';
import 'package:flutter_snd/domain/models/track_model.dart';
import 'package:flutter_snd/ui/pages/content/users_offers/widgets/offer_card.dart';

class ResponseScreen extends StatelessWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TrackPoolService service = TrackPoolService();
    Future<List<TrackModel>> futureJobs = service.fecthData();
    return FutureBuilder<List<TrackModel>>(
      future: futureJobs,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              TrackModel track = items[index];
              return PostCard(
                  nombre: track.name,
                  album: track.albumName,
                  artista: "${index + 1}  ${track.artistName}",
                  duracion: "${track.playbackSeconds} Segundos");
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

