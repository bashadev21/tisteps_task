import 'package:dartz/dartz.dart';
import 'package:tisteps/src/data/models/user_detail.dart';
import 'package:tisteps/src/data/models/user_list.dart';

import '../../common/failure.dart';

abstract class UsersListRepository {
  Future<Either<Failure, UserData>> GetUser({int pageNumber});
  Future<Either<Failure, UserDetail>> getUserDetails({String userId});
}
