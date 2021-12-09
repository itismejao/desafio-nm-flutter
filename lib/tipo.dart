class Tipo {
  String _nome = "";
  List<String>? _img;
  double? _price;
  double? _listPrice;


  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  List<String>? get img => _img;

  set img(List<String>? value) {
    _img = value;
  }


  set listPrice(double? value) {
    _listPrice = value;
  }


  set price(double? value) {
    _price = value;
  }

  double? get listPrice => _listPrice;


  double? get price => _price;

}