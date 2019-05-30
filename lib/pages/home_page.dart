import 'dart:async';

import 'package:fastshop/pages/shopping_page.dart';
import 'package:fastshop/widgets/log_out_button.dart';
import 'package:fastshop/widgets/shopping_basket.dart';
import 'package:fastshop/widgets/shopping_basket_price.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class HomePage extends StatefulWidget {
  var user;
  HomePage({this.user});
  @override
  HomePageSample createState() => new HomePageSample(user: user);
}

class HomePageSample extends State<HomePage> with SingleTickerProviderStateMixin, WidgetsBindingObserver {

  TabController controller;
  var user;
  HomePageSample({this.user});

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido: ${this.user}'),
          leading: Container(),
          actions: <Widget>[
            LogOutButton(),
          ],
          bottom: new TabBar(
              isScrollable: true,
              controller: controller,
              tabs: <Tab>[
                new Tab(text: "Promociones vigentes",icon: new Icon(Icons.pages)),
                new Tab(text: "Listado de Compras",icon: new Icon(Icons.list)),
                new Tab(text: "Productos",icon: new Icon(Icons.shop)),
                new Tab(text: "Mis gastos",icon: new Icon(Icons.account_balance)),
              ]
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              
              ListTile(
                title: RaisedButton(
                  child: Text('Shopping'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => ShoppingPage(),
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                title: RaisedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Mi Carrito'),
                      SizedBox(
                        width: 16.0,
                      ),
                      ShoppingBasket(),
                      SizedBox(
                        width: 16.0,
                      ),
                      ShoppingBasketPrice(),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/shoppingBasket');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
