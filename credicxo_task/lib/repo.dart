import 'package:credicxo_task/track.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrackRepo {
  Future<List<Track>> fetchTracks() async {
    final response = await http.get(Uri.parse(
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7'));
    // print("response :${response.body}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var body = jsonDecode(response.body);
      print("bodyfetchTracks:${body["message"]["body"]['track_list']}");
      List<Track> tracks = [];
      for (var i = 0; i < body["message"]["body"]['track_list'].length; i++) {
        tracks.add(
          Track.fromJson(body["message"]["body"]['track_list'][i]["track"]),
        );
      }
      return tracks;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Track> fetchTrackDetail(int trackId) async {
    final response = await http.get(Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackId&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7'));
    // print("response :${response.body}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var body = jsonDecode(response.body);
      print("fetchTrackDetails: ${body}");
      Track track;
      track = Track.fromJson(body["message"]["body"]["track"]);
      return track;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<String> fetchTrackLyrics(int trackId) async {
    final response = await http.get(Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7'));
    // print("response :${response.body}");
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var body = jsonDecode(response.body);
      print("body lyrics:${body}");
      print("trackID:$trackId");
      String lyrics;
      lyrics = body["message"]["body"]["lyrics"]["lyrics_body"];
      return lyrics;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}