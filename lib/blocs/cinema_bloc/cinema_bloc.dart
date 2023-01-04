
import 'package:bookmyapp/apis/cinema_detail.dart';
import 'package:bookmyapp/models/cinema_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cinema_state.dart';
part 'cinema_event.dart';

class CinemaBloc extends Bloc<CinemaEvent, CinemaState>{
  var cinemaInfo;
  var error;
  CinemaBloc():super(CinemaInitial()){
    emit(CinemaLoading());
    on<FetchCinema>((event,emit)async {
      print("i am cinema bloc");
    try {
      cinemaInfo = await getCinemaDetail(event.id);
      print("cinemaInfo");
      emit(CinemaLoaded(cinemaInfo));
    } catch (err) {
      print("i am error");
     error = err.toString();
     emit(CinemaError(error));
    }
  });

  }


}
