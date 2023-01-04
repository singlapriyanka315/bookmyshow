import 'package:bookmyapp/apis/now_showing_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/now_showing.dart';
part 'movieNow_state.dart';
part 'movieNow_event.dart';

class MovieNowBloc extends Bloc<MovieNowEvent, MovieNowState> {
  List<FilmsNow> nowList = [];
  var error;
  MovieNowBloc() : super(StateLoading()) {
    on<FetchMovieNow>((event, emit) async {
      try {
        nowList = await getNow();
        emit(StateLoaded(nowList));
      } catch (err) {
        error = err.toString();
        emit(StateError(error));
      }
    });
  }
}



