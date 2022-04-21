import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class OrderProvider with ChangeNotifier {
  String baseUrl = 'https://www.umda.mobi/indexapi/getstatesdata/';

  Future<List> getUserOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var response = await http
        .get(Uri.parse('https://www.umda.mobi/orderapi/orderlist/'), headers: {
      "Content-type": "application/json",
      'Authorization': 'Token $token',
    });
    var body = json.decode(response.body);
    print(body);
    return body['results'];
  }

}
