part of 'activeTicket_bloc.dart';

abstract class ActiveTicketState extends Equatable {
  const ActiveTicketState();
  @override
  List<Object?> get props => [];
}

class ActiveTicketInitial extends ActiveTicketState {}

class ActiveTicketLoading extends ActiveTicketState {}

class ActiveTicketLoaded extends ActiveTicketState {
  List ticketsnow;
  ActiveTicketLoaded(this.ticketsnow);
  @override
  // TODO: implement props
  List<Object?> get props => [ticketsnow];
}

class ActiveTicketError extends ActiveTicketState {
  var error;
  ActiveTicketError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
