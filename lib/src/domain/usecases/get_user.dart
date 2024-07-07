import 'package:dartz/dartz.dart';
import 'package:tisteps/src/data/models/user_detail.dart';
import 'package:tisteps/src/data/models/user_list.dart';
import 'package:tisteps/src/domain/repositories/users_repo.dart';

import '../../common/failure.dart';

class GetUser {
  final UsersListRepository usersListRepository;
  GetUser(this.usersListRepository);
  Future<Either<Failure, UserData>> callUserList({int pageNumber = 1}) async {
    return await usersListRepository.GetUser(pageNumber: pageNumber);
  }

  Future<Either<Failure, UserDetail>> callUserData(
      {required String userId}) async {
    return await usersListRepository.getUserDetails(userId: userId);
  }
}
