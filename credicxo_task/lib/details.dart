
import 'package:credicxo_task/repo.dart';
import 'package:credicxo_task/track.dart';
import 'package:credicxo_task/trackBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TrackDetails extends StatelessWidget {
  final trackId;
  TrackDetails({required this.trackId});

  @override
  Widget build(BuildContext context) {
    final trackBloc = BlocProvider.of<TrackBloc>(context);
    trackBloc.add(FetchTrack(trackId));
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Track Details"),
          ),
          body: ListView(
            children: [
              BlocBuilder<TrackBloc,TrackState>(
                  builder: (context, state){
                    if(state is TrackIsLoading){
                      return const Center(child: CircularProgressIndicator());
                    }
                    else if(state is TrackIsLoaded){
                      Track track = state.getTrack;
                      print("track in is loaded:$track");
                      String lyrics = state.getLyrics;
                      print("lyrics in is loaded:$lyrics");
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 0, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           const Text(
                                "Name",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                                track.trackName,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                           SizedBox(
                             height: MediaQuery.of(context).size.height*0.02,
                           ),
                           const Text(
                                "Artist",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(track.artistName,style: TextStyle(
                              fontSize: 20,
                            )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.02,
                            ),
                           const Text("Album Name",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(track.albumName,style: TextStyle(
                              fontSize: 20,
                            )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.02,
                            ),
                            const  Text("Explicit",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${track.explicit == 1}",style: TextStyle(
                              fontSize: 20,
                            )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.02,
                            ),
                            const Text("Rating",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${track.rating}",style: TextStyle(
                              fontSize: 20,
                            )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.02,
                            ),
                            if(lyrics != "")
                           const Text("Lyrics",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if(lyrics != "")
                            Text(
                              lyrics,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(child: Text("Network Error"));
                  }
              )
            ],
          )
      ),
    );
  }
}




