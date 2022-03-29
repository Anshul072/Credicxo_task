import 'package:bloc/bloc.dart';
import 'package:credicxo_task/repo.dart';
import 'package:credicxo_task/track.dart';
import 'package:equatable/equatable.dart';


class TracksEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class FetchTracks extends TracksEvent{

}

class TracksState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class TracksIsLoading extends TracksState{

}

class TracksIsLoaded extends TracksState{
  final _tracks;

  TracksIsLoaded(this._tracks);

  List<Track> get getTracks => _tracks;

  @override
  // TODO: implement props
  List<Object?> get props => [_tracks];
}

class TracksIsNotLoaded extends TracksState{

}



class TracksBloc  extends Bloc<TracksEvent,TracksState>{

  TrackRepo trackRepo;

  TracksBloc(TracksState initialState,this.trackRepo) : super(initialState);
  TracksState get initialState => TracksIsLoading();

  @override
  Stream<TracksState> mapEventToState(TracksEvent event) async*{
    if(event is FetchTracks){
      yield TracksIsLoading();
      try{
        List<Track> tracks = await trackRepo.fetchTracks();
        yield TracksIsLoaded(tracks);
      }catch(_){
        yield TracksIsNotLoaded();
      }
    }
  }
}
