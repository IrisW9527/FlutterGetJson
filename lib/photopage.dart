import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'profilepage.dart';
// import 'loginpage.dart';

// fetch data from the api url:
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response =
      await client.get('https://prophase2.herokuapp.com/api/photos');
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<dynamic, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String id;
  final String title;
  final String image;
  final String userId;
  final String createdAt;
  final String updatedAt;
  final List<Comment> comments;
  // dynamic comments = new List<Comment>();

  Photo(
      {this.id,
      this.title,
      this.image,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.comments});

  factory Photo.fromJson(Map<dynamic, dynamic> json) {
    var list = json['comments'] as List;
    List<Comment> commentList = list.map((i) => Comment.fromJson(i)).toList();

    return new Photo(
      id: json['id'].toString(),
      title: json['title'],
      image: json['image'],
      userId: json['user_id'].toString(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      comments: commentList,
    );
  }
}

class Comment {
  String id;
  String description;
  String photoId;
  String createdAt;

  Comment({
    this.id,
    this.description,
    this.photoId,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json["id"].toString(),
      description: json["description"],
      photoId: json["photo_id"].toString(),
      createdAt: json["created_at"],
    );
  }
}

// display all photos of all users
class PhotoPage extends StatelessWidget {
  final String title;
  PhotoPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.account_circle),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => ProfilePage()),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// photolist
class PhotosList extends StatelessWidget {
  final List<Photo> photos;
  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        // return PhotoTile(photos[index]);

        return ListTile(
            leading: Text(photos[index].id),
            title: Text(photos[index].title),
            subtitle: Text(photos[index].image),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommentPage(comments: photos[index].comments)),
              );
            },
          );

      },
    );
  }
}


class CommentPage extends StatelessWidget {
  // CommentPage({Key key}) : super(key: key);
  // final List<Comment> comments;
  final List<Comment> comments;
  // final Comment comments;
  CommentPage({Key key, @required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      // body: Text('hi'),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return CommentTile(comments[index]);
        },
      ),
    );
  }
}


class CommentTile extends StatelessWidget {
  final Comment _comment;
  CommentTile(this._comment);

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          ListTile(
            leading: Text(_comment.id),
            title: Text(_comment.description),
            subtitle: Text(
              _comment.createdAt,
            ),
          ),
          Divider()
        ],
      );
}
