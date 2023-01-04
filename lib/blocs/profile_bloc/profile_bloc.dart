import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
     var profileData;
     var error;
    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());
      print("i am profilebloc");
      try {
    User? user = await FirebaseAuth.instance.currentUser;
    await user?.reload();
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    print(snapshot.data());
    print("1snapshot.data()");
     print(snapshot.data());

       profileData = snapshot.data();

    
       // print(snapshot.data()!['ticket'][0]['mydate']);
        emit(ProfileLoaded(profileData));
      } catch (err) {
        print(err);
        error = err.toString();
        emit(ProfileError(error));
      }
    });
  }
}
