import 'dart:convert';
import 'package:desafio/services/app_config.dart';
import 'package:desafio/services/cockpit_api.dart';
import 'package:desafio/product_page2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _processing = false;
  bool _passwordVisibility = false;

  TextEditingController _user = TextEditingController();
  TextEditingController _pass = TextEditingController();

  CockpitApi _cockpitApi = CockpitApi();

  final _formKey = GlobalKey<FormState>();

  int _errorCode = 0;

  AppConfig _appConfig = AppConfig();

  static const _messages = {
    0: 'Utilize seu Re e Senha do Vtrine para Entrar no aplicativo',
    1: 'Credenciais inválidas, tente novamente',
    2: 'Acesso negado neste momento',
    3: 'Credenciais inválidas, tente novamente',
    4: 'Sessão expirada, faça login novamente',
    5: 'Sessão expirada, faça login novamente',
    6: 'Ocorreu uma falha, tente novamente',
    7: 'Informe usuário e senha',
    999: 'Não foi possível conectar, tente novamente'
  };


  @override
  void initState() {
    _clearOldCredentials();
  }

  void validaCampos(){
    if ((_user.text == "") || (_pass.text == ""))
      setState(() {
        _errorCode = 7;
      });
    else
      login();
  }

  Future<void> login() async {
    setState(() {
      _processing = true;
    });


    var credentials = {'uid': _user.text, 'password': _pass.text};
    var options = {};

    options['body'] = json.encode(credentials);

    await _cockpitApi
        .postRequest(
            urlSegment: '/auth/ldap/login',
            options: options,
            checkAuth: false,
            context: context)
        .whenComplete(() {
      if (_cockpitApi.error == false && _cockpitApi.statusCode == 200) {
        try {
          var user = json.decode(_cockpitApi.body)['data'];

          var page = ProductPage2();

          _setLoggedUser(user).whenComplete(() {
            _processing = false;
            Navigator.pushReplacement(
                context, CupertinoPageRoute(builder: (context) => page));
          });
        } catch (e) {
          _errorCode = 999;
        }
      } else if (_cockpitApi.statusCode == 401) {
        var data = json.decode(_cockpitApi.body);

        if (data.containsKey('code')) {
          _errorCode = data['code'];
        }
      } else {
        _errorCode = 999;
      }
    });
    setState(() {
      _processing = false;
    });
  }

  Future _setLoggedUser(user) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('user.uid', user['uid']);
    prefs.setString('user.name', user['name']);
    prefs.setString('user.email', user['email']);
    prefs.setString('user.token', user['token']);
    prefs.setString('user.menu', json.encode(user['menu']));
    prefs.setString('apps', json.encode(user['apps']));
  }

  _clearOldCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('user.uid');
    prefs.remove('user.name');
    prefs.remove('user.email');
    prefs.remove('user.token');
    prefs.remove('user.menu');
    prefs.remove('apps');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _processing,
        child: Form(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(
                height: 5,
              ),
              Image(
                image: AssetImage('img/logo.png'),
                height: 100,
                width: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Text(_messages[_errorCode]!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: _errorCode == 0 ? Colors.blue[900] : Colors.red
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  controller: _user,
                  style: TextStyle(color: Colors.blue[900]),
                  decoration: InputDecoration(
                    hintText: "Usuário:",
                    focusColor: Colors.green,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue[900],
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextFormField(
                  obscureText: _passwordVisibility == true ? false : true,
                  controller: _pass,
                  style: TextStyle(color: Colors.blue[900]),
                  decoration: InputDecoration(
                    hintText: "Senha:",
                    focusColor: Colors.green,
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.blue[900],
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisibility == true ? Icons.visibility : Icons.visibility_off,
                        color: Colors.blue[900],
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisibility == true ? _passwordVisibility = false : _passwordVisibility = true;
                        });
                      },
                    )
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: validaCampos,
                child: Text("Entrar"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[900],
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
