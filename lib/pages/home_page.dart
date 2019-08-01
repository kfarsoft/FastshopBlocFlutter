import 'dart:async';
import 'package:fastshop/functions/getUsername.dart';
import 'package:fastshop/pages/active_offer.dart';
import 'package:fastshop/pages/category_page.dart';
import 'package:fastshop/pages/listados/shop_list_page.dart';
import 'package:fastshop/pages/shopping/cart_page.dart';
import 'package:fastshop/widgets/log_out_button.dart';
import 'package:fastshop/widgets/shopping_basket.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  HomePageSample createState() => new HomePageSample();
}

class HomePageSample extends State<HomePage> with SingleTickerProviderStateMixin {


  var user;
  Future<void> _getUsername() async {
    user = await getUsername();
  }

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPopScope() async {
    return false;
  }

  List<Widget> _tabItems() => [
    Tab(text: "Promociones",icon: new Icon(Icons.pages)),
    Tab(text: "Categorias",icon: new Icon(Icons.shop)),
    Tab(text: "Carrito",icon: new Icon(Icons.shopping_cart)),
    Tab(text: "Listado",icon: new Icon(Icons.list)),
  ];

  TabBar _tabBarLabel() => TabBar(
    tabs: _tabItems(),
    isScrollable: true,
    indicatorSize: TabBarIndicatorSize.tab,
    onTap: (index) {
      var content = "";
      switch (index) {
        case 0:
          content = "Promociones";
          break;
        case 1:
          content = "Categorias";
          break;
        case 2:
          content = "Carrito";
          break;
        case 3:
          content = "Listado";
          break;
        default:
          content = "Other";
          break;
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Bienvenido $user'),
            leading: LogOutButton(),
            actions: <Widget>[
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ShoppingBasket(),
                  ],
                ),
                onTap: () {Navigator.of(context).pushNamed('/shoppingBasket');},
              ),
            ],
            bottom: _tabBarLabel(),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: TabBarView(
                      children: <Widget>[
                        ActiveOfferPage(),
                        CategoryPage(),
                        BlocCartPage(),
                        ShopListPage()
                      ]
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}