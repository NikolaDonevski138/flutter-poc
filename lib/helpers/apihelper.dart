import 'dart:io';
import 'dart:convert';

import 'package:pocflutter/models/httpresponse.dart';
import 'package:pocflutter/models/image.dart';
import 'package:http/http.dart';

class APIHelper {
  static Future<HTTPResponse<List<ImageModel>>> getImagesApi() async {
    String url = 'https://jsonplaceholder.typicode.com/photos';
    try {
      var response = await get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<ImageModel> imageList = [];
        body.forEach((element) {
          ImageModel image = ImageModel.fromJson(element);
          imageList.add(image);
        });
        return HTTPResponse(true, imageList, responseCode: response.statusCode);
      } else {
        return HTTPResponse(false, null,
            message: 'Invalid response received from server',
            responseCode: response.statusCode);
      }
    } on SocketException {
      return HTTPResponse(false, null,
          message: 'Unable to reach the internet!');
    } on FormatException {
      return HTTPResponse(false, null,
          message: 'Invalid response received from server');
    } catch (e) {
      return HTTPResponse(false, null, message: 'Something went wrong');
    }
  }
}
