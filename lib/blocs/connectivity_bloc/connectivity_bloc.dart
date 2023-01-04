import 'package:bookmyapp/models/live_movies.dart';
import 'package:bookmyapp/screens/search_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../apis/Livefilm_api.dart';
part 'connectivity_state.dart';
part 'connectivity_event.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityInitial()) {
    var result;
    String error;
    on<FetchConnectivity>((event, emit) async {
      emit(ConnectivityLoading());
      print("i am connectivity_bloc");
      try {
        var subscription = await Connectivity()
            .onConnectivityChanged
            .listen((connectivityResult) async {
          result = await connectivityResult;
          print(result);
        });
        emit(ConnectivityLoaded(result));
      } catch (err) {
        print(err);
        error = err.toString();
        emit(ConnectivityError(error));
      }
    });
  }
}
