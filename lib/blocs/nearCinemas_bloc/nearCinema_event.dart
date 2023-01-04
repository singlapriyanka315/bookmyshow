part of 'nearCinema_bloc.dart';
abstract class NearCinemaEvent extends Equatable {
  const NearCinemaEvent();
  @override
  List<Object> get props => [];
}

class FetchNearCinema extends NearCinemaEvent {
  int id;
  String mydate;
  FetchNearCinema(this.id, this.mydate);
  @override
  List<Object> get props => [];
}
