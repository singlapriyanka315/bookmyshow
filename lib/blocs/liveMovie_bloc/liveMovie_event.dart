part of 'liveMovie_bloc.dart';

abstract class LiveMovieEvent extends Equatable{
  const LiveMovieEvent();
  @override
  List<Object> get props => [];
}

class FetchLiveMovie extends LiveMovieEvent{
  String searchVal= "";
  FetchLiveMovie(this.searchVal);
  @override
  List<Object> get props => [searchVal];

}

