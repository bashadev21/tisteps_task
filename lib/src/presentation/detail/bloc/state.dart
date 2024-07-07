import 'package:flutter/foundation.dart';
import 'package:tisteps/src/data/models/user_detail.dart';


@immutable
abstract class UserState {}

class UserInitial extends UserState {}

// State for initial Loading when current page will be 1
class UserInitialLoading extends UserState {
  final String message;
  UserInitialLoading({required this.message});
}

class UserInitialError extends UserState {
  final String message;
  UserInitialError({required this.message});
}

class UserLoaded extends UserState {
  final UserDetail user;

  UserLoaded({
    required this.user,
  });
}

