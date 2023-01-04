import 'package:bookmyapp/models/live_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../apis/Livefilm_api.dart';
part 'liveMovie_state.dart';
part 'liveMovie_event.dart';

class LiveMovieBloc extends Bloc<LiveMovieEvent, LiveMovieState> {
  LiveMovieBloc() : super(LiveMovieInitial()) {
    List<LiveFilm> liveFilmData = [];
    String error;
    on<FetchLiveMovie>((event, emit) async {
      emit(LiveMovieLoading());
      print("i am bloc");
      try {
        liveFilmData = await getLive(event.searchVal);
        // movieData = await getDetail(event.searchVal);

        // print(moviedata.film_name);
        print("i am name");
        emit(LiveMovieLoaded(liveFilmData));
      } catch (err) {
        print(err);
        error = err.toString();
        emit(LiveMovieError(error));
      }
    });
  }
}
