part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();
}
class ConnectivityInitial extends ConnectivityState {
 @override

  List<Object?> get props => [];
}

class ConnectivityLoading extends ConnectivityState {
  @override

  List<Object?> get props => [];
}

class  ConnectivityLoaded extends ConnectivityState {
   var result;
   ConnectivityLoaded(this.result);
  @override

  List<Object?> get props => [result];
}

class ConnectivityError extends ConnectivityState {
 var error;
  ConnectivityError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}