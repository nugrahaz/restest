import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:restest/app/constants/constants.dart';
import 'package:restest/app/models/user_model.dart';
import 'package:restest/app/utils/failure.dart';

class UserRepository {
  final http.Client _client = http.Client();

  Future<Either<Failure, bool>> createUserS(User user) async {
    var response = await _client.post(
      Uri.https(ApiPath.baseUrl, ApiPath.users),
      body: {
        'first_name': user.firstName,
        'last_name': user.lastName,
        'email': user.email,
        'avatar': user.avatar,
      },
    );
    

    if (response.statusCode == 200 || response.statusCode == 201) {
      return const Right(true);
    } else {
      return Left(Failure("Failed to create user"));
    }
  }

  Future<Either<Failure, List<User>>> readListUserS() async {
    List<User> users = [];

    var response = await _client.get(
      Uri.https(ApiPath.baseUrl, ApiPath.users),
    );
    
    print(Uri.https(ApiPath.baseUrl, ApiPath.users).toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> dataDecode = data['data'];
      users = dataDecode.map((userData) => User.fromJson(userData)).toList();

      return Right(users);
    } else {
      return Left(Failure("Failed to get list user"));
    }
  }

  Future<Either<Failure, bool>> updateUserS(User user) async {
    var response = await _client.put(
      Uri.https(ApiPath.baseUrl, "${ApiPath.users}/${user.id}"),
      body: {
        'first_name': user.firstName,
        'last_name': user.lastName,
        'email': user.email,
        'avatar': user.avatar,
      },
      
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return const Right(true);
    } else {
      return Left(Failure("Failed to update user"));
    }
  }

  Future<Either<Failure, bool>> deleteUserS(int userId) async {
    var response = await _client.delete(
      Uri.https(ApiPath.baseUrl, "${ApiPath.users}/$userId"),
      
    );

    if (response.statusCode == 204) {
      return const Right(true);
    } else {
      return Left(Failure("Failed to delete user: $userId"));
    }
  }
}
