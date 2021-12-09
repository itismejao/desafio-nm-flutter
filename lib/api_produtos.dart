import 'dart:io';

import 'package:desafio/produto.dart';
import 'package:desafio/tipo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiProdutos {
  List<Produto> listaProdutos = [];

  Future<List> getProducts(int valorInicial, int valorFinal,String? search) async {
    String UrlApi =
        "https://novomundo.vtexcommercestable.com.br/api/catalog_system/pub/products/search?_from=$valorInicial&_to=$valorFinal&ft=$search&fq=sellerId:1";
    http.Response response;

    response = await http.get(Uri.parse(UrlApi),
        headers:
        {
          HttpHeaders.authorizationHeader: 'Access-Control-Allow-Origin:*'
        });

    final jsonDecode = json.decode(response.body);

    adicionaProdutoLista(jsonDecode);

    return listaProdutos;
  }

  void adicionaProdutoLista(List json) {
    listaProdutos.clear();
    for (Map prod in json) {
      Produto produto = new Produto();
      produto.id = prod["productId"];
      produto.nome = prod["productName"];
      produto.description = prod["description"];
      produto.tipo = [];
      for (Map tip in prod["items"]){
        Tipo tipo = new Tipo();
        tipo.img = [];
        for (Map img2 in tip["images"]) {
          tipo.img!.add(img2["imageUrl"]);
        }
        tipo.nome = tip["name"];
        produto.tipo?.add(tipo);
        for (Map seller in tip["sellers"]){
          if (seller["sellerName"] == "Novo Mundo"){
            tipo.listPrice = seller["commertialOffer"]["ListPrice"];
            tipo.price = seller["commertialOffer"]["Price"];
            break;
          }
        }
      }
      listaProdutos.add(produto);
    }
  }
}
