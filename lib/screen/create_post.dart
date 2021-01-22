import 'package:flutter/material.dart';
import 'dart:math';
import '../helpers/apihelper.dart';
import '../models/post.dart';


class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  String _title;
  String _post;

  bool postFromResponse = false;
  Post message;
  String unsuccessfulMesage;

  final title = TextEditingController();
  final body = TextEditingController();
  final _form = GlobalKey<FormState>();

  void _createPost() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Random random = new Random();
    String randomNumber = random.nextInt(1000).toString();
    HttpService http = HttpService();

    final Post post = await http.createPost(randomNumber, _title, _post);

    if (post?.id != null) {
      setState(() {
        message = post;
        postFromResponse = true;
        _showMyDialog();
      });
    } else {
      _showMyDialog();
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                postFromResponse
                    ? Text('Your post was Successfully created')
                    : Text(
                        'Your post was not successfull created please try again later',
                        style: TextStyle(color: Colors.red),
                      )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  decoration: InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  onSaved: (val) => {_title = val},
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Blog'),
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'This field should not be empty';
                    }

                    return null;
                  },
                  onSaved: (val) => {_post = val},
                ),
                //Container(child: postFromResponse ? Text('${message.id}') : null,),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: RaisedButton(
                    child: Text(
                      'Create Blog',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: _createPost,
                    color: Colors.purple,
                    textColor: Colors.white,
                    splashColor: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
