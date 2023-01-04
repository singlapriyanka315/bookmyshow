import 'package:bookmyapp/apis/movie_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'detailMovie_state.dart';
part 'detailMovie_event.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  DetailMovieBloc() : super(DetailMovieInitial()) {
    var movieData;
    var error;
    bool flag = true;
    on<FetchDetailMovie>((event, emit) async {
      emit(DetailMovieLoading());
      try {
        movieData = await getDetail(event.movieId);
        emit(DetailMovieLoaded(movieData));
      } catch (err) {
        error = err.toString();
        emit(DetailMovieError(error));
      }
    });
  }
}
