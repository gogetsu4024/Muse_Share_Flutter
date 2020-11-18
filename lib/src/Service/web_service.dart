import 'package:flutter_login_signup/src/Config/AppConfig.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


var dio = new Dio();

class WebService {

  Future<int> login(var username, var password, BuildContext context) async {
    var params = {"username": username, "password": password};

    String url =AppConfig.URL_SIGNIN;
    final response = await http.post(url, body: {"username": username, "password": password});
    print(response.body);
    if (response.statusCode == 200) {
      return 1;
      //print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return -1;
    }
  }


  }
