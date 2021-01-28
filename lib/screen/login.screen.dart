import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import './home.screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username;
  String _password;

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return isAvailable;

    isAvailable
        ? print('Biometric is available!')
        : print('Biometric is unavailable.');

    return isAvailable;
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> availableBiometrics =
        await _localAuthentication.getAvailableBiometrics();

    print(availableBiometrics);

    if (availableBiometrics.contains(BiometricType.face)) {
      print('facee');
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      print('fingerprint');
    }
  }

  Future<void> _authenticateUser() async {
    bool isAuthenticated = false;
    const ANDROID_AUTH_MESSAGES = AndroidAuthMessages(
      signInTitle: 'Biometric Authentication',
    );
  
    try {
      isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
          localizedReason: "Please authenticate to view your images",
          useErrorDialogs: true,
          stickyAuth: true,
          androidAuthStrings: ANDROID_AUTH_MESSAGES);
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    isAuthenticated
        ? print('User is authenticated!')
        : print('User is not authenticated.');

    if (isAuthenticated) {
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }

  final _form = GlobalKey<FormState>();

  void _login() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Navigator.pushNamed(context, HomeScreen.routeName);
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
                      onSaved: (val) => {_password = val}),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Container(
                      child: Column(children: [
                        RaisedButton(
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: _login,
                          color: Colors.blue,
                          textColor: Colors.white,
                          splashColor: Colors.black,
                        ),
                        RaisedButton(
                          child: Text(
                            'Login with biometics',
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () async {
                            if (await _isBiometricAvailable()) {
                              await _getListOfBiometricTypes();
                              await _authenticateUser();
                            }
                          },
                          color: Colors.blue,
                          textColor: Colors.white,
                          splashColor: Colors.black,
                        ),
                      ]),
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
