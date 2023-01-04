part of 'nearCinema_bloc.dart';

abstract class NearCinemaState extends Equatable {
  const NearCinemaState();
}

class NearCinemaInitial extends NearCinemaState {
  @override
  List<Object?> get props => [];
}

class NearCinemaLoading extends NearCinemaState {
  @override
  List<Object?> get props => [];
}

class NearCinemaLoaded extends NearCinemaState {
  List cinemadata=[];
  NearCinemaLoaded(this.cinemadata);
  @override
  // TODO: implement props
  List<Object?> get props => [cinemadata];
}

class NearCinemaError extends NearCinemaState {
  var error;
  NearCinemaError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
