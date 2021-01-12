import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = 'AIzaSyBg9yn5JtQgKRFbg6FCTy4ewbF24kRuAYI';

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.locationiq.com/v2/staticmap?key=pk.0ca27b9f7c9d3ecd8767b915f826a8b6&center=$latitude,$longitude&zoom=16&size=480x480&markers=$latitude,$longitude';
  }

  static Future<dynamic> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://eu1.locationiq.com/v1/reverse.php?key=pk.0ca27b9f7c9d3ecd8767b915f826a8b6&lat=$lat&lon=$lng&format=json';
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return data;
  }
}
