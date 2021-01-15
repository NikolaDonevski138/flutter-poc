import 'package:flutter/material.dart';

import './home.screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username;
  String _password;

  final _form = GlobalKey<FormState>();

  void _login() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Navigator.pushNamed(context, HomeScreen.routeName);
    print(_username.length);
    print(_password);
  }

  @override
  Widget build(BuildContext context) {
    print(_username);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 7,
            child: Form(
              key: _form,
              child: ListView(
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Name'),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Username';
                      }
                      return null;
                    },
                    onSaved: (val) => {_username = val},
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Password';
                      }
                      if (value.length < 6) {
                        return 'Password Should be at least 6 characters long.';
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: RaisedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: _login,
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
