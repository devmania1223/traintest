part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class FetchProfile extends ProfileEvent {
  final String email;

  const FetchProfile({@required this.email});

  @override
  List<Object> get props => [email];
}

class RefreshProfile extends ProfileEvent {
  final User user;

  const RefreshProfile({@required this.user});

  @override
  List<Object> get props => [];
}
