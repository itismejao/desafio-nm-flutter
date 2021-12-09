
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../login.dart';
import 'app_config.dart';
import 'fake_response.dart';
import 'package:flutter/foundation.dart';
import 'util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CockpitApi {
  
  String body;
  int statusCode;
  bool error;

  CockpitApi({
    this.body = '',
    this.statusCode = 0,
    this.error = false
  });

  static AppConfig appConfig = AppConfig();

  String _baseUrl = appConfig.baseUrl;

  String _token = '';

  Future postRequest({@required String? urlSegment, var options, bool checkAuth: true, required BuildContext context}) async {
    var url = Uri.parse(_baseUrl + urlSegment!);
    
    error = false;

    try {
      // get token first
      _token = (await getStringFromSP('user.token'))!;


      // user fake
      //if (_token == 'user_token_999999' || options['body'].toString().contains('"uid":"999999"')) {
      //  await Future.delayed(const Duration(seconds : 2));
      //  fakeRequest(requestBody: options['body'], checkAuth: checkAuth, context: context);

     // } else {

        await http.post(
          url,
          headers: {
            //HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: "Basic $_token",
           // 'x-cockpit-platform': platform,
            //'x-cockpit-version': version
          },
          body: options['body']
        )
        .timeout(const Duration(seconds: 60))
        .then((response) {
          statusCode = response.statusCode;
          body = response.body;
          if (checkAuth == true && statusCode == 401) {
            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginPage())); //Error Code
          } else if (statusCode < 200 || statusCode >= 300) {
            error = true;
          } else if (statusCode != 200) {
            error = true;
          }
        });
     // }
    } catch(e) {
      print(e);
      error = true;
    }
    
  }

  void fakeRequest({required String requestBody, required bool checkAuth, required BuildContext context}) {
    statusCode = 200;

    Map data = json.decode(requestBody);
    
    if (data.containsKey('uid')) {
      
      if (data['uid'] != '999999' || data['password'] != '999999') {
        statusCode = 401;
        body = FakeResponse().authFailed();
      } else {
        body = FakeResponse().auth();
      }
    
    } else if (data.containsKey('tipo')) {
      String tipo = data['tipo'];

      if (tipo == 'indicador') {

        if (data.containsKey('detalhe')) {
          body = FakeResponse().detalhe(data['detalhe']);
        } else {
          body = FakeResponse().indicador();
        }
      
      } else if (tipo == 'filtros') {
        body = FakeResponse().filtros();
      
      } else if (tipo == 'departamentos') {
        body = FakeResponse().departamentos();
      
      } else {
        statusCode = 500;
      }

    }

    if (checkAuth == true && statusCode == 401) {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginPage())); //Error Code
    } else if (statusCode < 200 || statusCode >= 300) {
      error = true;
    } else if (statusCode != 200) {
      error = true;
    }

  }

}