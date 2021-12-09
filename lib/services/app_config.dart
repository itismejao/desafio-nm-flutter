
import 'package:flutter/material.dart';

class AppConfig {

  final String title = 'Cockpit Novo Mundo';
  final String baseUrl = _getValue('base_url');
  final colors = _getValue('colors');

  final aboutCockpit = 'O cockpit é o app da Novo Mundo de visualização de indicadores.\n\nAproveite e acompanhe seus resultados.\n\nProduzido por Novo Mundo Labs.\n\nVersão 1.0.0';

  final String androidVersion = '1.0.0';
  final String iosVersion = '1.6';
  
  static _getValue(key) {
    
    String env = 'production';

    Map configs = {};
    
    configs['base_url'] = 'https://cockpith.novomundo.com.br/api';

    configs['colors'] = {
      'primary_color': Color(0xff52b3e3),
      'primary_color_dark': Color(0xff3faae0),
      'rounded_1': Color(0xff52b3e3),
      'rounded_2': Color(0xffb5e62a43),
      'rounded_label': Color(0xff52b3e3),
      'card_positivo': Color(0xff3faae0),
      'card_negativo': Color(0xffb5e62a43),
      'splash_screen_background': Color(0xffe62a43),
      'login_screen_background': Color(0xff3faae0),
      'appbar_background': Colors.white,
      'appbar_text': Colors.black,
      'icon': Colors.black,
    };

    if (env == 'production') {
      configs['base_url'] = 'https://cockpit.novomundo.com.br/api';
    }

    return configs[key];
  }

}
