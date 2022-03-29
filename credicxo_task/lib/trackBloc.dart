import 'package:bloc/bloc.dart';
import 'package:credicxo_task/repo.dart';
import 'package:credicxo_task/track.dart';
import 'package:equatable/equatable.dart';

class TrackEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class FetchTrack extends TrackEvent{
  final _trackId;
  FetchTrack(this._trackId);

  @override
  // TODO: implement props
  List<Object?> get props => [_trackId];
}

class TrackState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class TrackIsLoading extends TrackState{

}
class TrackIsLoaded extends TrackState{
  final _track;
  final _lyrics;
  Track get getTrack => _track;
  String get getLyrics => _lyrics;
  TrackIsLoaded(this._track, this._lyrics);
  @override
  // TODO: implement props
  List<Object?> get props => [_track,_lyrics];
}
class TrackIsNotLoaded extends TrackState{

}

class TrackBloc extends Bloc<TrackEvent ,TrackState>{
  TrackRepo trackRepo;
  TrackBloc(TrackState initialState,this.trackRepo) : super(initialState);

  @override
  Stream<TrackState> mapEventToState(TrackEvent event) async*{
    String lyrics="";
    if(event is FetchTrack){
      yield TrackIsLoading();
      try{
        Track track = await trackRepo.fetchTrackDetail(event._trackId);
        if(track.hasLyrics == 1) {
          lyrics = await trackRepo.fetchTrackLyrics(event._trackId);
        }
        print("track in is bloc:$track");
        print("lyrics in is bloc:$lyrics");
        yield TrackIsLoaded(track,lyrics);
      }catch(_){
        yield TrackIsNotLoaded();
      }
    }
  }
}