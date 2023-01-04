part of 'cinema_bloc.dart';

abstract class CinemaEvent extends Equatable {
  const CinemaEvent();
  @override
  List<Object> get props => [];
}

class FetchCinema extends CinemaEvent {
  int id;
  FetchCinema(this.id);
  @override
  List<Object> get props => [];
}
