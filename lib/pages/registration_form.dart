import 'package:fastshop/bloc_widgets/bloc_state_builder.dart';
import 'package:fastshop/blocs/registration/registration_bloc.dart';
import 'package:fastshop/blocs/registration/registration_event.dart';
import 'package:fastshop/blocs/registration/registration_form_bloc.dart';
import 'package:fastshop/blocs/registration/registration_state.dart';
import 'package:fastshop/widgets/pending_action.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController _usernameController;
  TextEditingController _nameController;
  TextEditingController _lastnameController;
  TextEditingController _emailController;
  TextEditingController _passController;
  TextEditingController _passRetypeController;
  TextEditingController _docController;
  RegistrationFormBloc _registrationFormBloc;
  RegistrationBloc _registrationBloc;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _nameController = TextEditingController();
    _lastnameController = TextEditingController();
    _emailController = TextEditingController();
    _passController = TextEditingController();
    _passRetypeController = TextEditingController();
    _docController = TextEditingController();
    _registrationFormBloc = RegistrationFormBloc();
    _registrationBloc = RegistrationBloc();
  }

  @override
  void dispose() {
    _registrationBloc?.dispose();
    _registrationFormBloc?.dispose();
    _usernameController?.dispose();
    _nameController?.dispose();
    _lastnameController?.dispose();
    _emailController?.dispose();
    _passController?.dispose();
    _passRetypeController?.dispose();
    _docController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocEventStateBuilder<RegistrationState>(
        bloc: _registrationBloc,
        builder: (BuildContext context, RegistrationState state) {
          if (state.isBusy) {
            return PendingAction();
          } else if (state.isSuccess) {
            return _buildSuccess();
          } else if (state.isFailure) {
            return _buildFailure();
          }
          return _buildForm();
        });
  }

  Widget _buildSuccess() {
    return Center(
      child: Text('Exitoso'),
    );
  }

  Widget _buildFailure() {
    return Center(
      child: Text('Error'),
    );
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        children: <Widget>[

          new SizedBox(height: 4),
          //USERNAME
          StreamBuilder<String>(
              stream: _registrationFormBloc.username,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Container(
                  height: 100.0,
                  child: new ListTile(
                    //leading: const Icon(Icons.account_circle),
                    title: TextField(
                      decoration: new InputDecoration(
                        labelText: 'Usuario',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        errorText: snapshot.error,
                      ),
                      controller: _usernameController,
                      onChanged: _registrationFormBloc.onUsernameChanged,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                );
              }),

          /*//NAME
          StreamBuilder<String>(
              stream: _registrationFormBloc.name,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Container(
                  height: 60.0,
                  child: ListTile(
                    //leading: const Icon(Icons.person),
                    title: TextField(
                      decoration: new InputDecoration(
                        labelText: 'Nombre',
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        errorText: snapshot.error,
                      ),
                      controller: _nameController,
                      onChanged: _registrationFormBloc.onNameChanged,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                );
              }),

          //LASTNAME
          StreamBuilder<String>(
              stream: _registrationFormBloc.lastname,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Container(
                  height: 60.0,
                  child: ListTile(
                    //leading: const Icon(Icons.person_outline),
                    title: TextField(
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        labelText: 'Apellido',
                        errorText: snapshot.error,
                      ),
                      controller: _lastnameController,
                      onChanged: _registrationFormBloc.onLastnameChanged,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                );
              }),*/

          //EMAIL
          StreamBuilder<String>(
              stream: _registrationFormBloc.email,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Container(
                  height: 100.0,
                  child: ListTile(
                    //leading: const Icon(Icons.email),
                    title: TextField(
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        labelText: 'Email',
                        errorText: snapshot.error,
                      ),
                      controller: _emailController,
                      onChanged: _registrationFormBloc.onEmailChanged,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                );
              }),

          //PASSWORD
          StreamBuilder<String>(
              stream: _registrationFormBloc.password,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Container(
                  height: 100.0,
                  child: ListTile(
                    //leading: const Icon(Icons.remove_red_eye),
                    title: TextField(
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        labelText: 'Contraseña',
                        errorText: snapshot.error,
                      ),
                      controller: _passController,
                      obscureText: true,
                      onChanged: _registrationFormBloc.onPasswordChanged,
                    ),
                  ),
                );
              }),

          //RETYPE PASSWORD
          StreamBuilder<String>(
              stream: _registrationFormBloc.confirmPassword,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Container(
                  height: 100.0,
                  child: ListTile(
                    //leading: const Icon(Icons.remove_red_eye),
                    title: TextField(
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                        labelText: 'Repita contraseña',
                        errorText: snapshot.error,
                      ),
                      controller: _passRetypeController,
                      obscureText: true,
                      onChanged: _registrationFormBloc.onRetypePasswordChanged,
                    ),
                  ),
                );
              }),
/*
          //DOCUMENT
          StreamBuilder<String>(
              stream: _registrationFormBloc.doc,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Container(
                  height: 60.0,
                  child: ListTile(
                    leading: const Icon(Icons.date_range),
                    title: TextField(
                      decoration: InputDecoration(
                        labelText: 'Documento',
                        errorText: snapshot.error,
                      ),
                      controller: _docController,
                      onChanged: _registrationFormBloc.onDocChanged,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                );
              }),*/

          //FORM BLOC
          StreamBuilder<bool>(
              stream: _registrationFormBloc.registerValid,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return new ButtonTheme.bar(
                  child: new ButtonBar(
                    children: <Widget>[
                      new SizedBox(
                        height: 48.0,
                        child: new RaisedButton(
                        child: Text('Registrar'),
                        color: Colors.white,
                        elevation: 4.0,
                        onPressed: (snapshot.hasData && snapshot.data == true)
                            ? () {
                                _registrationBloc.emitEvent(RegistrationEvent(
                                    event: RegistrationEventType.working,
                                    username: _usernameController.text,
                                    //name: _nameController.text,
                                    //lastname: _lastnameController.text,
                                    email: _emailController.text,
                                    password: _lastnameController.text));
                              }
                            : null,
                      ),
                    ),
                      new SizedBox(
                        height: 48.0,
                        child:new RaisedButton(
                          child: const Text("Borrar", textScaleFactor: 1.5),
                          color: Colors.white,
                          onPressed: () {_clearForm();},
                          elevation: 4.0,
                        ),
                      ),
                    ]
                  ),
                );
              }
              ),
        ],
      ),
    );
  }

  void _clearForm(){
    _usernameController.clear();
    _nameController.clear();
    _lastnameController.clear();
    _emailController.clear();
    _passController.clear();
    _passRetypeController.clear();
    _docController.clear();
  }
}
