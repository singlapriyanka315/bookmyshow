part of 'movieNow_bloc.dart';

abstract class MovieNowState extends Equatable {
  const MovieNowState();
}

class StateInitial extends MovieNowState {
  @override
  List<Object?> get props => [];
}

class StateLoading extends MovieNowState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class StateLoaded extends MovieNowState {
  List<FilmsNow> nowList = [];
  StateLoaded(this.nowList);
  @override
  List<Object?> get props => [nowList];
}

class StateError extends MovieNowState {
  String locationError;
  StateError(this.locationError);
  @override
  List<Object?> get props => [locationError];
}
