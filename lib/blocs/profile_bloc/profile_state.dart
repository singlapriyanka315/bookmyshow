part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
}


class ProfileLoading extends ProfileState {
}

class  ProfileLoaded extends ProfileState {
  var profileData;
   ProfileLoaded(this.profileData);
  @override
  // TODO: implement props
  List<Object?> get props => [profileData];
}

class  ProfileError extends ProfileState {

  var error;
  ProfileError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}
