import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();
}

class LogoutButtonPressed extends LogoutEvent {
  @override
  List<Object> get props => [];
}