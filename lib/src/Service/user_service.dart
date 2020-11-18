import 'dart:convert';
import 'package:flutter_login_signup/src/Config/AppConfig.dart';
import 'package:flutter_login_signup/src/Models/User.dart';
import 'package:http/http.dart' as http;

class UserWebService {

  Future<User> login(var username, var password) async {
    var params = {"username": username, "password": password};

    String url =AppConfig.URL_SIGNIN;
    final response = await http.post(url, body: {"username": username, "password": password});
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      return User.fromJson(body["user"]);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
  }
