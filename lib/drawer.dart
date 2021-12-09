import 'package:desafio/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomDrawer extends StatelessWidget {

  String userName = "";

  CustomDrawer(this.userName);


  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.blue[900]!
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
    );

    return Drawer(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 250,
                child: Stack(
                  children: [
                    Positioned(
                        child:  Image(
                          image: AssetImage('img/logo.png'),
                          height: 100,
                          width: 200,
                        ),),
                    Positioned(
                        top: 100, left: 0,
                    child: Text("Catálogo \nde Produtos",style: TextStyle(
                      fontSize: 34, fontWeight: FontWeight.bold, color: Colors.indigo[900]
                    ),
                    ),
                    ),
                    Positioned(
                      left: 0,
                        bottom: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Olá, ${userName.split(" ")[0]+" "+userName.split(" ")[1]}!",style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ) ,
                            ),
                            GestureDetector(
                              child: Text(
                                "Clique aqui para deslogar >",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              onTap: (){
                                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginPage()));
                              },
                            )
                          ],
                        )
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}
