import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisteps/src/presentation/home/bloc/event.dart';
import 'package:tisteps/src/presentation/home/bloc/state.dart';

import '../../../data/models/user_list.dart';
import '../../../domain/usecases/get_user.dart';

class UsersBloc extends Bloc<UserListEvent, UsersState> {
  UserData userData = UserData(
    data: [],
    page: 1,
    perPage: 6,
    total: 0,
    totalPages: 0,
  );

  UsersBloc(this.userGet) : super(UsersInitial()) {
    on<UserListEvent>((event, emit) async {
      if (event is LoadUserList) {
        bool isInitial = userData.page == 1;
        if (isInitial) {
          emit(UsersInitialLoading(message: 'Fetching Users....'));
        } else {
          emit(UsersLoaded(
            users: userData,
            isLoadingMore: true,
          ));
        }

        final response = await userGet.callUserList(pageNumber: userData.page!);
        response.fold(
          (l) {
            if (isInitial) {
              emit(UsersInitialError(message: 'Failed to load Users'));
            } else {
              emit(UsersLoaded(
                users: userData,
                error: LoadMoreError(message: 'Failed to load more Users'),
              ));
            }
          },
          (r) {
            if (isInitial) {
              userData = UserData(
                data: r.data,
                page: 2,
                totalPages: r.totalPages,
              );

              if (userData.data!.isEmpty) {
                emit(UsersEmpty());
              } else {
                emit(UsersLoaded(
                  users: userData,
                  hasMoreData: userData.page! <= userData.totalPages!,
                ));
              }
            } else {
              userData = UserData(
                data: userData.data! + r.data!,
                page: userData.page! + 1,
                totalPages: r.totalPages,
              );
              emit(UsersLoaded(
                users: userData,
                hasMoreData: userData.page! <= userData.totalPages!,
              ));
            }
          },
        );
      }
    });
  }

  final GetUser userGet;
}
