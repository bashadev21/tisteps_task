import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tisteps/src/data/models/user_detail.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';
import '../../domain/repositories/users_repo.dart';
import '../datasources/users_data_source.dart';
import '../models/user_list.dart';

class UsersRepositoryImpl extends UsersListRepository {
  UsersRepositoryImpl(this.dataSource);
  final UserRemoteDataSource dataSource;

  @override
  Future<Either<Failure, UserData>> GetUser({int? pageNumber}) async {
    try {
      final result = await dataSource.GetUser(pageSize: pageNumber!);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(
        ConnectionFailure('No internet connection'),
      );
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['message'].toString() ??
              'Error occured Please try again',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserDetail>> getUserDetails({String? userId}) async {
    try {
      final result = await dataSource.getUserDetail(userId: userId!);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(
        ConnectionFailure('No internet connection'),
      );
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['message'].toString() ??
              'Error occured Please try again',
        ),
      );
    }
  }
}
