import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'seats_state.dart';
part 'seats_event.dart';

class SeatsBloc extends Bloc<SeatsEvent, SeatsState> {
  SeatsBloc() : super(SeatsInitial()) {
     List ticket = [];
     var error;
    on<FetchSeats>((event, emit) async {
      emit(SeatsLoading());
      print("i am seatsbloc");
      try {
    final snapshot = await FirebaseFirestore.instance
        .collection('bookseats')
        .doc('movie_name')
        .get();
    print(snapshot.data());
    print("1snapshot.data()");
    if (snapshot.data()!['${event.movieName}'] != null) {
      print("2snapshot.data()");
      if (snapshot.data()!['${event.movieName}']
              ['${event.cinemaName}'] !=
          null) {
             print("3snapshot.data()");
            
        if (snapshot.data()!['${event.movieName}']
                ['${event.cinemaName}']['${event.date}'] !=
            null) {
               print("4snapshot.data()");
          if (snapshot.data()!['${event.movieName}']
                  ['${event.cinemaName}']['${event.date}']['${event.time}'] !=
              null) {
                 print("5snapshot.data()");
                var len = (snapshot.data()!['${event.movieName}']
                  ['${event.cinemaName}']['${event.date}']['${event.time}']).length;
                  print("length f array");
                  print(len);

                  ticket =  snapshot.data()!['${event.movieName}']
                  ['${event.cinemaName}']['${event.date}']['${event.time}'];
                  print(ticket);
          } else {
            print("yes");
            ticket=[];
    
          }
        } else {
          print("yes");
          ticket=[];
        }
      } else {
        print("yes");
        ticket=[];     
      }
    }
    else {
            print("yes");
            ticket=[];
          }
        print(ticket);
        print("i am name");
        emit(SeatsLoaded(ticket));
      } catch (err) {
        print(err);
        error = err.toString();
        emit(SeatsError(error));
      }
    });
  }
}
