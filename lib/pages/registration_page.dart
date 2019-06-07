import 'package:fastshop/pages/registration_form.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Fastshop - Registrate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RegistrationForm(),
      ),
    );
  }
}