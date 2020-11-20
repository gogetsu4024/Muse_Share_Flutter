import 'dart:convert';
import 'package:flutter_login_signup/src/Config/AppConfig.dart';
import 'package:flutter_login_signup/src/Models/User.dart';
import 'package:http/http.dart' as http;

class UserWebService {

  Future<User> login(var username, var password) async {
    var params = {"username": username, "password": password};

    String url = AppConfig.URL_SIGNIN;
    final response = await http.post(url, body: params);
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      return User.fromJson(body["user"]);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<User> register(var username, var firstName, var lastName, var password, var email) async {
    var params = {
      "username": username,
      "firstname": firstName,
      "lastname": lastName,
      "password": password,
      "email": email
    };

    String url = AppConfig.URL_REGISTER;
    final response = await http.post(url, body: params);
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      return User.fromJsonArray(body["user"]);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  }
