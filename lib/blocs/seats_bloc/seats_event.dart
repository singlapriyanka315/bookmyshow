part of 'seats_bloc.dart';

abstract class SeatsEvent extends Equatable{
  const SeatsEvent();
  @override
  List<Object> get props => [];

}

class FetchSeats extends SeatsEvent{
  var movieName, cinemaName, date, time;
  FetchSeats({required this.movieName, required this.cinemaName, required this.date, required this.time});
  @override
  List<Object> get props => [movieName, cinemaName, date, time];

}


