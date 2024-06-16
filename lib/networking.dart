import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class networking {
  networking(this.URL);
  final String URL;

  dynamic getdata() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      var url = Uri.parse(URL);
      http.Response response = await http.get(url);
      String s = response.body;
      var decodeddata = jsonDecode(s);
      return decodeddata;
    } catch (e) {
      print(e);
    }
  }
}
