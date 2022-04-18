import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:educa_feedback/models/user.dart';
import 'package:educa_feedback/repositories/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfile) {
      yield* _mapFetchProfileToState(event);
    } else if (event is RefreshProfile) {
      yield* _mapRefreshProfileToState(event);
    }
  }

  bool _sameProfile(ProfileState state, email) =>
      state is ProfileLoaded && state.user.email == email;

  Stream<ProfileState> _mapFetchProfileToState(FetchProfile event) async* {
    final currentState = state;

    if (!_sameProfile(currentState, event.email)) {
      yield ProfileLoading();
      try {
        final user = await userRepository.getUserInfo(event.email);
        yield ProfileLoaded(user: user);
      } catch (_) {
        yield ProfileError();
      }
    } else {
      yield currentState;
    }
  }

  Stream<ProfileState> _mapRefreshProfileToState(RefreshProfile event) async* {
    yield ProfileLoaded(user: event.user);
  }
}
