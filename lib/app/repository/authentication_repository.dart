import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:restest/app/constants/constants.dart';
import 'package:restest/app/utils/failure.dart';

class AuthenticationRepository {
  final http.Client _client = http.Client();

  Future<Either<Failure, String>> loginS(String email, String password) async {
    print(email);
    print(password);
    final response = await _client.post(
      Uri.https(ApiPath.baseUrl, ApiPath.login),

      body: {
        'email': email,
        'password': password,
      },
    );
      print(response.body);
    print(response.statusCode);


    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return Right(data['token'].toString());
    } else {
      if (kDebugMode) {
        print('Login Failed because : ${jsonDecode(response.body)}');
      }
      return Left(Failure("Login Failure"));
    }
  }

  Future<Either<Failure, bool>> logoutS() async {
    final response = await _client.post(
      Uri.https(ApiPath.baseUrl, ApiPath.logout),
      
    );
    if (kDebugMode) {
      print(response);
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return const Right(true);
    } else {
      if (kDebugMode) {
        print('Logout Failure because : + ${jsonDecode(response.body)}');
      }
      return Left(Failure("Logout Failure"));
    }
  }
  

  Future<Either<Failure, String>> registerS(String email, String password) async {
    final response = await _client.post(
      Uri.https(ApiPath.baseUrl, ApiPath.register),
      
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);
      if (kDebugMode) {
        print('Register Success');
      }
      return Right(data['token'].toString());
    } else {
      if (kDebugMode) {
        print('Register Failed because : ${jsonDecode(response.body)}');
      }
      return Left(Failure("Login Failure"));
    }

  }


}
