import 'dart:convert';

import 'package:flutter_snd/domain/models/public_job.dart';
import 'package:flutter_snd/domain/services/misiontic_interface.dart';
import 'package:http/http.dart' as http;

// Servicio encargado de obtener las ofertas laborales
class WorkPoolService implements MisionTicService {
  final String baseUrl = 'misiontic-2022-uninorte.herokuapp.com';
  final String apiKey = 'AWP8xGyDxJH8A.FaAWD7ku7uZLhqTom4dyRBKGVAjlAOsNrjp0W1.';

  @override
  Future<List<PublicJob>> fecthData({int limit = 5, Map? map}) async {
    var queryParameters = {'limit': limit.toString()};
    var uri = Uri.https(baseUrl, '/jobs', queryParameters);

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // We add our service ApiKey to the request headers
        'key': apiKey
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final List<PublicJob> jobs = [];
      for (var job in res['jobs']) {
        jobs.add(PublicJob.fromJson(job));
      }
      return jobs;
    } else {
      throw Exception('Error on request');
    }
  }
}
