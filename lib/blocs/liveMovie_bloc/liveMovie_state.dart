part of 'liveMovie_bloc.dart';

abstract class LiveMovieState extends Equatable {
  const LiveMovieState();
}

class LiveMovieInitial extends LiveMovieState {
  @override
  List<Object?> get props => [];
}

class LiveMovieLoading extends LiveMovieState {
  @override
  List<Object?> get props => [];
}

class LiveMovieLoaded extends LiveMovieState {
  List<LiveFilm> liveFilmData = [];
  LiveMovieLoaded(this.liveFilmData);
  @override
  List<Object?> get props => [liveFilmData];
}

class LiveMovieError extends LiveMovieState {
  var error;
  LiveMovieError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
