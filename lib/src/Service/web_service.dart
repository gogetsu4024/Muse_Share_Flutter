import 'dart:convert';

import 'package:flutter_login_signup/src/Config/AppConfig.dart';
import 'package:flutter_login_signup/src/Models/User.dart';
import 'package:flutter_login_signup/src/Session/Singleton.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


var dio = new Dio();

class WebService {

  Future<int> login(var username, var password, BuildContext context) async {
    var params = {"username": username, "password": password};

    String url =AppConfig.URL_SIGNIN;
    final response = await http.post(url, body: {"username": username, "password": password});
    if (response.statusCode == 200) {
      Singleton _instance = Singleton.getState();
      dynamic body = jsonDecode(response.body);
      User user = User.fromJson(body["user"]);
      _instance.logged_in_user = user;
      return 1;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return -1;
    }
  }
  }
