part of 'activeTicket_bloc.dart';

abstract class ActiveTicketEvent extends Equatable {
  const ActiveTicketEvent();
  @override
  List<Object> get props => [];
}

class FetchActiveTicket extends ActiveTicketEvent {
  FetchActiveTicket();
  @override
  List<Object> get props => [];
}
