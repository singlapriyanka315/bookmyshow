part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();
  @override
  List<Object> get props => [];
}

class FetchConnectivity extends ConnectivityEvent {
  FetchConnectivity();
  @override
  List<Object> get props => [];
}
