import 'package:desafio/api_produtos.dart';
import 'package:desafio/drawer.dart';
import 'package:desafio/login.dart';
import 'package:desafio/product_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProductPage2 extends StatefulWidget {
  const ProductPage2({Key? key}) : super(key: key);

  @override
  _ProductPage2State createState() => _ProductPage2State();
}

class _ProductPage2State extends State<ProductPage2> {
  ApiProdutos apiProdutos = new ApiProdutos();
  ScrollController _scrollController = new ScrollController();
  TextEditingController _searchControler = new TextEditingController();
  int _valorInicial = 0;
  int _valorFinal = 11;
  String _search = "";
  String userName = "";
  int qtdProdutos = 12;


  @override
  void initState() {
    _loadUserInfo();
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

  //Recuperar nome do usuário logado
  _loadUserInfo() async {
    if (! mounted) {
      return;
    }

    await SharedPreferences.getInstance()
        .then((prefs) {
          setState(() {
            userName = prefs.getString('user.name') ?? "";
          });

    });
  }

  SpeedDialChild speedDialChildOption(int qtd){
    return SpeedDialChild(
        child: Text(qtd.toString(),style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue[900],
        onTap: () {
          if (qtdProdutos != qtd) {
            setState(() {
              _valorFinal = (_valorFinal - qtdProdutos) + qtd;
              qtdProdutos = qtd;
            });
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: SpeedDial(
          child: Text((qtdProdutos).toString()),
          backgroundColor: Colors.blue[900],
          children: [
            if (qtdProdutos != 12) speedDialChildOption(12),
            if (qtdProdutos != 24) speedDialChildOption(24),
            if (qtdProdutos != 48) speedDialChildOption(48)
          ],
        ),
        drawer: CustomDrawer(userName),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Image.network(
              "https://novomundo.vtexassets.com/arquivos/v2-logo-novo-mundo.png?v=20211118192650"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.grid_on),
              ),
              Tab(
                icon: Icon(Icons.list),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(29),
              ),
              child: TextFormField(
                style: TextStyle(color: Colors.blue[900]),
                controller: _searchControler,
                decoration: InputDecoration(
                  hintText: "Pesquise:",
                  focusColor: Colors.green,
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search ,
                    color: Colors.blue[900],
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                          Icons.send ,
                          color: Colors.blue[900]
                      ),
                    onPressed: (){
                        setState(() {
                          _search = _searchControler.text;
                        });
                    },
                  ),
                ),
                keyboardType: TextInputType.text,
                onFieldSubmitted:  (text) {
                  setState(() {
                    _search = text;
                    _valorInicial = 0;
                    _valorFinal = 11;
                  });
                },
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: apiProdutos.getProducts(_valorInicial, _valorFinal, _search),
                  builder: (context, AsyncSnapshot snapshot) {
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
                          return TabBarView(
                            //physics: NeverScrollableScrollPhysics(),
                            children: [
                              GridView.builder(
                                controller: _scrollController,
                                padding: EdgeInsets.all(4),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4,
                                    childAspectRatio: 0.65),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return ProductTile("grid", snapshot.data[index]);
                                },
                              ),
                              ListView.builder(
                                controller: _scrollController,
                                padding: EdgeInsets.all(4),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return ProductTile("list", snapshot.data[index]);
                                },
                              ),
                            ],
                          );
                    }
                  },
                ),)
          ],
        )
      ),
    );
  }

  //Mostrar dialogo e carregar mais produtos
  void mostrarMaisProdutos() {
    Widget cancelaButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continuaButton = TextButton(
      child: Text("Sim"),
      onPressed: () {
        Navigator.pop(context);
        setState(() {
          _valorInicial = _valorFinal + 1;
          _valorFinal = _valorFinal + qtdProdutos;
        });
      },
    );
    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Você chegou no final da página!"),
      content: Text("Deseja carregar mais $qtdProdutos produtos?"),
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
