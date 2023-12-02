// import 'dart:async';
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:restest/app/constants/constants.dart';
//
// class AuthenticationService {
//   Future<bool> loginS(String email, String password) async {
//     final response = await http.post(
//       Uri.https(ApiPath.baseUrl, ApiPath.login),
//       
//       body: json.encode({
//         'email': email,
//         'password': password,
//       }),
//     );
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       var data = jsonDecode(response.body);
//       print('Login Success with : ${data}');
//       print(data['token']);
//
//
//       return true;
//     } else {
//       // throw LoginFailure();
//       print('Login Failed because : ${jsonDecode(response.body)}');
//       return false;
//     }
//   }
//
//   Future<bool> logoutS() async {
//     final response =
//         await http.post(Uri.https(ApiPath.baseUrl, ApiPath.logout));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print('Logout Success');
//       return true;
//
//       /// delete all data from secure storage when logout
//     } else {
//       print('Logout Failure because : + ${jsonDecode(response.body)}');
//
//       // throw LogoutFailure();
//       return false;
//     }
//   }
//
//   Future<bool> registerS(String email, String password) async {
//     var response = await http.post(
//       Uri.https(ApiPath.baseUrl, ApiPath.register),
//       body: {
//         'email': email,
//         'password': password,
//       },
//     );
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print('Register Success with : ${jsonDecode(response.body)}');
//       return true;
//     } else {
//       // throw LoginFailure();
//       print('Register Failed because : ${jsonDecode(response.body)}');
//       return false;
//     }
//   }
// }
