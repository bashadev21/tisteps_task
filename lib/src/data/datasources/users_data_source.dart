import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tisteps/src/data/models/user_detail.dart';

import '../../common/api.dart';
import '../models/user_list.dart';

abstract class UserRemoteDataSource {
  Future<UserData> getUser({int pageSize = 1});
  Future<UserDetail> getUserDetail({required String userId});
}

class UsersRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<UserData> getUser({int pageSize = 1}) async {
    try {
      String url = "${API.USERS}$pageSize";

      final response = await dio.get(
        url,
      );

      final data = userDataFromJson(jsonEncode(response.data));
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDetail> getUserDetail({required String userId}) async {
    try {
      final response = await dio.get(
        "${API.USER_DETAIL}$userId",
      );
      print(response.data);
      final data = userDetailFromJson(jsonEncode(response.data));
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
