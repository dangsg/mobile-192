import 'dart:async';

import 'package:MOVIES/block/authentication_bloc/authentication_event.dart';
import 'package:MOVIES/block/authentication_bloc/authentication_state.dart';
import 'package:MOVIES/data/repositoties/user_repositories.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';


class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();
      Future.delayed(Duration(seconds: 2), () async {

    });
      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      if(event.token==null){

        yield AuthenticationUnauthenticated();
      }
      else{
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
      }
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
    if(event is Register){
      yield AuthenticationRegister();
    }
    if (event is Login){
      yield AuthenticationUnauthenticated();
    }
  }
}