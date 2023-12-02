// import 'dart:async';
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
// import 'package:restest/app/constants/constants.dart';
// import 'package:restest/app/models/user_model.dart';
//
// class UserService {
//   Future<bool> createUserS(User user) async {
//    
//    
//     var response = await http.post(
//       Uri.https(ApiPath.baseUrl, ApiPath.users),
//       body: {
//     'first_name': user.firstName,
//     'last_name': user.lastName,
//     'email': user.email,
//     'avatar': user.avatar,
//     },
//     );
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print('Create Success');
//       return true;
//     } else {
//       // throw LoginFailure();
//       print('Failed to create user');
//       return false;
//     }
//   }
//
//
//   Future<List<User>> readListUserS() async {
//     List<User> users = [];
//
//     final response = await http.get(Uri.https(ApiPath.baseUrl, ApiPath.users));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       Map<String, dynamic> data = json.decode(response.body);
//       List<dynamic>  dataDecode = data['data'];
//       users = dataDecode.map((userData) => User.fromJson(userData)).toList();
//
//       return users;
//     } else {
//       print('Failed to load users');
//       return users;
//     }
//   }
//
//   Future<bool> updateUserS(User user) async {
//     var response = await http.put(
//       Uri.https(ApiPath.baseUrl, "${ApiPath.users}/${user.id}"),
//     );
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print('Update Success');
//       return true;
//     } else {
//       // throw LoginFailure();
//       print('Failed to update user: ${user.id}');
//       return false;
//     }
//   }
//
//
//   Future<bool> deleteUserS(int userId) async {
//     var response = await http.delete(
//       Uri.https(ApiPath.baseUrl, "${ApiPath.users}/$userId"),
//     );
//
//     if (response.statusCode == 204) {
//       print('Delete Success');
//       return true;
//     } else {
//       // throw LoginFailure();
//       print('Failed to delete user: $userId');
//       return false;
//     }
//   }
//
//
//    
//
// }
