import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// var autotoken;

// sign in an user --> send a http POST request
Future<http.Response> signinUser(String email, String password) async {
  String url = 'http://prophase2.herokuapp.com/api/sessions';

  final http.Response response = await http.post(url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
      body: jsonEncode(<String, String> {
      'email':email,
      'password':password,
    }),
  );
  print(response.body);
  return response;
  // if (response.statusCode == 200) {
  //   // return User.fromJson(json.decode(response.body));
  //   // return response.body; 
  // } else {
  //   // throw Exception('Failed to CREATE.');
  // }
}


// create a new user --> send a http POST request
Future<http.Response> createUser(String username,String email,String password) async {
  String url = 'http://prophase2.herokuapp.com/api/users';

  final http.Response response = await http.post(url,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
      body: jsonEncode(<String, String> {
      'username':username,
      'email':email,
      'password':password,
    }),
  );
  return response;
}


// User userFromJson(String str) {
//   final jsonData = json.decode(str);
//   return User.fromJson(jsonData);
// }

// String userToJson(User data) {
//   final dyn = data.toJson();
//   return json.encode(dyn);
// }

// define User class
class User {
  int id;
  String email;
  String username;
  String password;
  String autotoken;

  User({
    this.id,
    this.email,
    this.username,
    this.password,
    this.autotoken,
  });

  // constructing a new user instance from a map structure
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      autotoken: json['autotoken'],
    );
  }

  // User.fromJson(Map<String, dynamic> json)
  //     : email = json['email'],
  //       password = json['password'];

  // convert a user instance to a json map
  // Map<String, dynamic> toJson() => {
  //       'email': email,
  //       'password': password,
  //     };
}
