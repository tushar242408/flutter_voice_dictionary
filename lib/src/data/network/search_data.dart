import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task1/src/model/search_result_model.dart';


class ApiHandler{
  Future getData(String search)async{
    try {
      print('Response status====================================: $search');
      var _header = {
        "Authorization": "Token " + '08a5e3222b8be11a8bdcbaa455cb0f7ab1e7f608'
      };
      var url = Uri.parse('https://owlbot.info/api/v4/dictionary/$search');
      var response = await http.get(url, headers: _header);
      print('Response status===================: ${response.statusCode}');
      print('Response body: ${response.body}');
      var result = await jsonDecode(response.body);
      final _speechData = SpeechResponse.fromJson(result);
      print(_speechData.pronunciation);
      print(_speechData.definitions);
      return _speechData;
    }
    catch(e){
      return null;

    }


  }
}