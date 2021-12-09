import 'package:desafio/tipo.dart';

class Produto{
  String? _id;
  String _nome = "";
  List<String>? _img;
  double? _preco;
  List<Tipo>? _tipo;
  int? indiceTipo = null;
  String _description = "";

  String? get id => _id;

  String get nome => _nome;

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  double? get preco => _preco;

 List<String>? get img => _img;

 List<Tipo>? get tipo => _tipo;

  set preco(double? value) {
    _preco = value;
  }

  set img(List<String>? value) {
    _img = value;
  }

  set nome(String value) {
    _nome = value;
  }

  set id(String? value) {
    _id = value;
  }

  set tipo(List<Tipo>? value) {
    _tipo = value;
  }

}