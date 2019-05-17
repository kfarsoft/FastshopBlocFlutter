import 'package:fastshop/bloc_helpers/bloc_provider.dart';
import 'package:fastshop/blocs/authentication/authentication_bloc.dart';
import 'package:fastshop/blocs/cart/cart_boc.dart';
import 'package:fastshop/blocs/shopping/shopping_bloc.dart';
import 'package:fastshop/pages/cart_page.dart';
import 'package:fastshop/pages/decision_page.dart';
import 'package:fastshop/pages/initialization_page.dart';
import 'package:fastshop/pages/registration_page.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: AuthenticationBloc(),
      child: BlocProvider<ShoppingBloc>(
        bloc: ShoppingBloc(),
        child: BlocProvider<CartBloc>(
          bloc: CartBloc(),
          child: MaterialApp(
            title: 'BLoC Samples',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              '/decision': (BuildContext context) => DecisionPage(),
              '/register': (BuildContext context) => RegistrationPage(),
              '/shoppingBasket': (BuildContext context) => CartPage(),
            },
            home: InitializationPage(),
          ),
        ),
      ),
    );
  }
}
