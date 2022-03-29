import 'package:credicxo_task/connectivity_provider.dart';
import 'package:credicxo_task/details.dart';
import 'package:credicxo_task/repo.dart';
import 'package:credicxo_task/trackBloc.dart';
import 'package:credicxo_task/tracksBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    final trackBloc = BlocProvider.of<TracksBloc>(context);
    trackBloc.add(FetchTracks());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Trending')),
        ),
        body: pageUI()
      ),
    );
  }

  Widget pageUI(){
    return Consumer<ConnectivityProvider>(
        builder: (context, model ,child){
          if(model.isOnline != null){
            return model.isOnline! ? BlocBuilder<TracksBloc,TracksState>(
              builder: (context, state){
                if(state is TracksIsLoading) {

                  return const Center(child: CircularProgressIndicator());
                }
                else if(state is TracksIsLoaded){
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.98,
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: ListView(
                        children: state.getTracks.map((e) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: ListTile(
                            leading: const Icon(Icons.music_note),
                            title: Text(
                              e.trackName,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              e.albumName,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            trailing: SizedBox(
                              width: MediaQuery.of(context).size.width*0.2,
                              child: Text(
                                e.artistName,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>BlocProvider(
                                    create: (BuildContext context) => TrackBloc(TrackIsLoading(), TrackRepo()),
                                    child: TrackDetails(trackId: e.trackId,),
                                  )));
                            },
                          ),
                        )).toList()
                    ),
                  );
                }
                return const Center(child:Text("Network error"));
              },
            ):const Center(child: Text("No Internet"),);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }
}



