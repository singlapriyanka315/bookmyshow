import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_state.dart';
part 'order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
     var orders;
     var error;
    on<FetchOrder>((event, emit) async {
      emit(OrderLoading());
      print("i am orderbloc");
      try {
    User? user = await FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    print(snapshot.data());
    print("1snapshot.data()");
    // print(snapshot.data()!['ticket'][0]);
     if(snapshot.data()!['ticket']!=null){
      orders=snapshot.data()!['ticket'];
     }
     else{

      orders=[];

     }
     
     //   print(snapshot.data()!['ticket'][0]['mydate']);
        emit(OrderLoaded(orders));
      } catch (err) {
        print(err);
        error = err.toString();
        emit(OrderError(error));
      }
    });
  }
}
