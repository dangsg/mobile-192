import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpButtonPressed extends SignUpEvent {
  final String username;
  final String password;
  final String repassword;


  const SignUpButtonPressed({
    @required this.username,
    @required this.password,
    @required this.repassword,
  });

  @override
  List<Object> get props => [username, password,repassword];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}
class SignUpSuccessEvent extends SignUpEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}