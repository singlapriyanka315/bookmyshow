part of 'detailMovie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
  @override
  List<Object> get props => [];
}

class FetchDetailMovie extends DetailMovieEvent {
  int movieId;
  FetchDetailMovie(this.movieId);
  @override
  List<Object> get props => [movieId];
}
