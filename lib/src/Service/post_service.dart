import 'dart:convert';
import 'package:flutter_login_signup/src/Config/AppConfig.dart';
import 'package:flutter_login_signup/src/Models/Post.dart';
import 'package:http/http.dart' as http;

class PostWebService {

  Future<List<Post>> fetchPosts(int user_id) async {
    // should fetch posts from followed users and current user's posts only
    String url =AppConfig.URL_ALL_POSTS;
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
      ).toList();
      return posts;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<List<Post>> fetchPostsForUser(int user_id) async {
    String url =AppConfig.URL_USER_POSTS;
    final response = await http.get(url + user_id.toString());
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
      ).toList();
      print(posts[0].user.username);
      return posts;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<List<Post>> likePost(int post_id, int user_id) async {
    String url =AppConfig.URL_USER_POSTS;
    final response = await http.get(url + user_id.toString());
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
      ).toList();
      print(posts[0].user.username);
      return posts;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
