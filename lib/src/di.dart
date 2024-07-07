import 'package:get_it/get_it.dart';
import 'package:tisteps/src/domain/repositories/users_repo.dart';
import 'package:tisteps/src/domain/usecases/get_user.dart';
import 'package:tisteps/src/presentation/detail/bloc/bloc.dart';
import 'package:tisteps/src/presentation/home/bloc/bloc.dart';

import 'data/datasources/users_data_source.dart';
import 'data/repositories/users_repo_impl.dart';

GetIt locator = GetIt.instance;

void init() {
  try {
    locator.registerLazySingleton<UserRemoteDataSource>(
      () => UsersRemoteDataSourceImpl(),
    );

    locator.registerLazySingleton<UsersListRepository>(
      () => UsersRepositoryImpl(locator<UserRemoteDataSource>()),
    );
    locator.registerLazySingleton<GetUser>(
      () => GetUser(locator<UsersListRepository>()),
    );
    locator.registerLazySingleton<UsersBloc>(
      () => UsersBloc(locator<GetUser>()),
    );
    locator.registerLazySingleton<UserDetailBloc>(
      () => UserDetailBloc(locator<GetUser>()),
    );
  } catch (e) {
    rethrow;
  }
}
