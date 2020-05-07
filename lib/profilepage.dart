// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'User.dart';
// import 'package:dio/dio.dart';

// // retrive user profile data from api

// // method 1 
// String url = 'http://prophase2.herokuapp.com/api/profiles/13';
// Future<Profile> getProfile() async{
//   final response = await http.get(url);
//   print(response.body);
//   return profileFromJson(response.body);
// }

// method 2
// String autotoken = ;
// Map<String,String> queryParameter = {
//   'autotoken': autotoken,
// };
// var uri = new Uri.http('http://prophase2.herokuapp.com/api/profiles/13', queryParameter);
// Future<http.Response> getProfile() async {
//   final http.Response response = await http.get(uri, headers: {
//     HttpHeaders.contentTypeHeader: 'application/json',
//   });
//   return response;
// }


// Profile profileFromJson(String str) {
//   final jsonData = json.decode(str);
//   return Profile.fromJson(jsonData);
// }

// // profile model
// class Profile {
//   final String firstname;
//   final String lastname;
//   final String bio;

//   Profile({
//     this.firstname,
//     this.lastname,
//     this.bio,
//   });

//   factory Profile.fromJson(Map<String, dynamic> json) => Profile(
//         firstname: json["firstname"],
//         lastname: json["lastname"],
//         bio: json["bio"],
//       );

//   Map<String, dynamic> toJson() => {
//         "firstname": firstname,
//         "lastname": lastname,
//         "bio": bio,
//       };
// }

// class ProfilePage extends StatelessWidget {
//   final String title;
//   ProfilePage({Key key, this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       // body: Text('this is me'),
//       body: FutureBuilder(
//         future: getProfile(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) print(snapshot.error);
//           return Text('${snapshot.data.firstname}');
//         },
//       ),
//     );
//   }
// }
