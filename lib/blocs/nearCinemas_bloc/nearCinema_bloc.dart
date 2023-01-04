import 'package:bookmyapp/apis/closest_showing.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'nearCinema_state.dart';
part 'nearCinema_event.dart';

class NearCinemaBloc extends Bloc<NearCinemaEvent, NearCinemaState> {
  List cinemadata = [];
  var error;
  NearCinemaBloc() : super(NearCinemaInitial()) {
     print("i loading nearcinema bloc");
    
      on<FetchNearCinema>((event, emit) async {
         emit(NearCinemaLoading());
      print("i am nearcinema bloc");
      try {
        cinemadata = await getCinema(event.id, event.mydate);
        print("cinemadata");
        // print(moviedata.film_name);
        print(cinemadata.length);
        emit(NearCinemaLoaded(cinemadata));
      } catch (err) {
        print("i am error");
        error = err.toString();
        emit(NearCinemaError(error));
      }
    });
  }
}
