import 'package:carousel_slider/carousel_slider.dart';
import 'package:desafio/produto.dart';
import 'package:desafio/tela_produto.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductTile extends StatelessWidget {
  String tipo;
  Produto produto;

  ProductTile(this.tipo, this.produto);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => TelaProduto(produto))
        );
      },
      child: Card(
          child: tipo == 'grid'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: produto.tipo![0].img!
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
                        //enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(1),
                        child: Column(
                          children: [
                            Text(
                              produto.nome,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            produto.tipo![0].listPrice! > produto.tipo![0].price! ?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("de: ",style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                                    Text(
                                      "R\$" + produto.tipo![0].listPrice!.toStringAsFixed(2),
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
                                  "R\$" + produto.tipo![0].price!.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[900]
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
            children: [
              Flexible(
                flex: 1,
                child: CarouselSlider(
                  items: produto.tipo![0].img!
                      .map<Widget>(
                        (e) => ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: e,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    aspectRatio: 3 / 4,
                    //enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        produto.nome,
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      produto.tipo![0].listPrice! > produto.tipo![0].price! ?
                      Row(
                        children: [
                          Text("de: ",style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey)),
                          Text(
                              "R\$" + produto.tipo![0].listPrice!.toStringAsFixed(2),
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
                        children: [
                          Text("por ",style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          )),
                          Text(
                            "R\$" + produto.tipo![0].price!.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900]
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}
