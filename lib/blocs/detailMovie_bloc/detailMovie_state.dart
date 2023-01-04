part of 'detailMovie_bloc.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();
  @override
  List<Object?> get props => [];
}

class DetailMovieInitial extends DetailMovieState {}

class DetailMovieLoading extends DetailMovieState {}

class DetailMovieLoaded extends DetailMovieState {
  var movieData;
  DetailMovieLoaded(this.movieData);
  @override
  List<Object?> get props => [movieData];
}

class DetailMovieError extends DetailMovieState {
  var error;
  DetailMovieError(this.error);
  @override
  List<Object?> get props => [error];
}
