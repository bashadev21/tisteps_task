import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisteps/src/data/models/user_detail.dart';

import '../../../domain/usecases/get_user.dart';
import 'event.dart';
import 'state.dart';

class UserDetailBloc extends Bloc<UserEvent, UserState> {
  UserDetail userDetail = UserDetail();
  UserDetailBloc(this.userGet) : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoadUser) {
        emit(UserInitialLoading(message: 'Fetching Data....'));
        final response =
            await userGet.callUserData(userId: event.userId.toString());
        response.fold(
          (l) {
            emit(UserInitialError(message: 'Failed to load User'));
          },
          (r) {
            userDetail = UserDetail(data: r.data);
            emit(UserLoaded(
              user: userDetail,
            ));
          },
        );
      }
    });
  }

  final GetUser userGet;
}
