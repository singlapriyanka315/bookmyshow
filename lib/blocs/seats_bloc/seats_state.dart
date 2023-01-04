part of 'seats_bloc.dart';

abstract class SeatsState extends Equatable {
  const SeatsState();
  @override
  List<Object?> get props => [];
}

class SeatsInitial extends SeatsState {
}


class SeatsLoading extends SeatsState {
}

class  SeatsLoaded extends SeatsState {
  List ticket = [];
   SeatsLoaded(this.ticket);
  @override
  // TODO: implement props
  List<Object?> get props => [ticket];
}

class  SeatsError extends SeatsState {
  var error;
  SeatsError(this.error);
  @override
  List<Object?> get props => [error];
}