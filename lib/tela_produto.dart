import 'package:carousel_slider/carousel_slider.dart';
import 'package:desafio/produto.dart';
import 'package:desafio/tipo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class TelaProduto extends StatefulWidget {
  final Produto produto;

  TelaProduto(this.produto);

  @override
  _TelaProdutoState createState() => _TelaProdutoState(produto);
}

class _TelaProdutoState extends State<TelaProduto> {
  final Produto produto;
  int _indexTipo = 0;


  _TelaProdutoState(this.produto);


  String dropdownValue = "One";


  @override
  void initState() {
    dropdownValue = produto.tipo![0].nome;
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          produto.nome,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider(
                carouselController: _controller,
                items: produto.tipo![_indexTipo].img!
                    .map<Widget>(
                      (e) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: e,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    aspectRatio: 1 / 1,
                    enlargeCenterPage: true,
                    autoPlay: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Positioned(
                bottom: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: produto.tipo![_indexTipo].img!
                      .asMap()
                      .entries
                      .map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.blue
                                        : Colors.blue[900])!
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  produto.nome,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              produto.tipo![_indexTipo].listPrice! > produto.tipo![_indexTipo].price! ?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("de: ",style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey)),
                  Text(
                      "R\$" + produto.tipo![_indexTipo].listPrice!.toStringAsFixed(2),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey
                      )
                  )
                ],
              ) :
              SizedBox(
                height: 15,
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("por ",style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                    )),
                    Text(
                      "R\$ " +
                          produto.tipo![_indexTipo].price!.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                produto.tipo!.length > 1 ? mostrarTipo() : Container(),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Descrição\n",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Text(
                  produto.description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mostrarTipo() {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Text(
          "Tipo",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 8,
        ),
        produto.tipo![0].nome.length < 25
            ? SizedBox(
                height: 50,
                child: Center(
                  child: GridView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.5),
                    children: produto.tipo!
                        .map((e) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  _indexTipo = produto.tipo!.indexOf(e);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        _indexTipo == produto.tipo!.indexOf(e)
                                            ? Colors.blue[900]!
                                            : null,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      color: Colors.blue[900]!,
                                    )),
                                width: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  e.nome,
                                  style: TextStyle(
                                      color:
                                          _indexTipo == produto.tipo!.indexOf(e)
                                              ? Colors.white
                                              : null),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ))
            : DropdownButton(
          isExpanded: true,
          value: dropdownValue,
          underline: Container(
            height: 2,
            color: Colors.blue[900],
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              int contador = 0;
              for (Tipo t in produto.tipo!) {
                if (t.nome == newValue) {
                  _indexTipo = contador;
                } else {
                  contador++;
                }
              }
            });
          },
                items: produto.tipo
                    !.map((e) {
                  return DropdownMenuItem(
                    value: e.nome,
                    child: Text(e.nome,
                        ),
                  );
                }).toList(),
              )
      ],
    );
  }
}
