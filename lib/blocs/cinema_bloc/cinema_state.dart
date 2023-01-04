part of 'cinema_bloc.dart';

abstract class CinemaState extends Equatable {
  const CinemaState();
}

class CinemaInitial extends CinemaState {
  @override
  List<Object?> get props => [];
}

class CinemaLoading extends CinemaState {
  @override
  List<Object?> get props => [];
}

class CinemaLoaded extends CinemaState {
  var cinemaInfo;
  CinemaLoaded(this.cinemaInfo);
  @override
  // TODO: implement props
  List<Object?> get props => [cinemaInfo];
}

class CinemaError extends CinemaState {
  var error;
  CinemaError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
