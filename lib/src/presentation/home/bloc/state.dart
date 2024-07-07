import 'package:flutter/foundation.dart';

import '../../../data/models/user_list.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

// State for initial Loading when current page will be 1
class UsersInitialLoading extends UsersState {
  final String message;
  UsersInitialLoading({required this.message});
}

class UsersInitialError extends UsersState {
  final String message;
  UsersInitialError({required this.message});
}

class UsersEmpty extends UsersState {}

class UsersLoaded extends UsersState {
  final UserData users;
  final bool isLoadingMore;
  final bool hasMoreData;
  final LoadMoreError? error;

  UsersLoaded({
    required this.users,
    this.isLoadingMore = false,
    this.hasMoreData = true,
    this.error,
  });
}

// LoadingMoreError Model
class LoadMoreError {
  final String message;
  LoadMoreError({required this.message});
}
