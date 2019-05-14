import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/authentication/authentication_bloc.dart';
import 'package:fastshop/blocs/shopping/shopping_bloc.dart';
import 'package:fastshop/pages/decision_page.dart';
import 'package:fastshop/pages/initialization_page.dart';
import 'package:fastshop/pages/registration_page.dart';
import 'package:fastshop/pages/shopping_basket_page.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: AuthenticationBloc(),
      child: BlocProvider<ShoppingBloc>(
        bloc: ShoppingBloc(),
        child: MaterialApp(
          title: 'BLoC Samples',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/decision': (BuildContext context) => DecisionPage(),
            '/register': (BuildContext context) => RegistrationPage(),
            '/shoppingBasket': (BuildContext context) => ShoppingBasketPage(),
          },
          home: InitializationPage(),
        ),
      ),
    );
  }
}
