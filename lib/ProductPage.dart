import 'package:carousel_slider/carousel_slider.dart';
import 'package:desafio/api_produtos.dart';
import 'package:desafio/produto.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String? search = "";
  int valorInicial = 0;
  int valorFinal = 11;
  ScrollController _scrollController = new ScrollController();
  ApiProdutos apiProdutos = new ApiProdutos();
  List<Produto> listaProdutos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        mostrarMaisProdutos();
      }
    });
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Image.network(
            "https://novomundo.vtexassets.com/arquivos/v2-logo-novo-mundo.png?v=20211118192650"),
        centerTitle: true,
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            decoration: InputDecoration(
              labelText: "Pesquise aqui:",
              labelStyle: TextStyle(color: Colors.blue[900]),
              border: OutlineInputBorder(),
            ),
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
            onSubmitted: (text) {
              setState(() {
                search = text;
              });
            },
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: apiProdutos.getProducts(valorInicial, valorFinal, search),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200,
                      height: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        strokeWidth: 5,
                      ),
                    );
                  default:
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return Container();
                    } else
                      return _createProductTable(context, snapshot);
                }
              }),
        ),
      ]),
    );
  }

  Widget _createProductTable(BuildContext context, AsyncSnapshot snapshot) {
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(10),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              child: Card(
            child: Container(
              width: 120,
              height: 120,
              child: Column(
                children: [
                  CarouselSlider(
                    items: snapshot.data[index].tipo[0].img
                        .map<Widget>(
                          (e) => ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: e,
                                //height: 300,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      autoPlay: true,
                    ),
                  ),
                  mostrarNome(snapshot.data[index]),
                  mostrarPreco(snapshot
                          .data[index]
                          .tipo[0]
                          .listPrice)
                ],
              ),
            ),
          ));
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 1 : 3,
        ),
      );
    });
  }

  Widget mostrarNome(Produto prod) {
    return Text(
      prod.nome,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }

  Widget mostrarPreco(double preco) {
    return Text(
      "R\$ " + preco.toString(),
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void mostrarMaisProdutos() {
    Widget cancelaButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continuaButton = TextButton(
      child: Text("Continuar"),
      onPressed: () {
        Navigator.pop(context);
        setState(() {
          valorInicial = valorFinal + 1;
          valorFinal = valorFinal + 12;
        });
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Você chegou no final da página!"),
      content: Text("Deseja carregar mais 12 produtos?"),
      actions: [
        cancelaButton,
        continuaButton,
      ],
    );
    //exibe o diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
