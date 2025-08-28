import 'dart:convert';

import 'package:ai_bot/data/url.dart';
import 'package:http/http.dart' as http;

class APIHelper{
Future<Map<String,dynamic>?> sendMsgApi({required String msg})async{
  try{
    var response = await http.post(
      Uri.parse("${Url.gemoniBaseUrl}?key=${Url.ApiKey}"),
      headers: {
        "Content-Type": "application/json",
        "X-goog-api-key":"Bearer ${Url.ApiKey}"
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text":msg}
            ]
          }
        ]
      }),
    );
    if(response.statusCode == 200 && response.body.isNotEmpty){
      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      return decoded;
    }else{
      print("faild with status code:${response.statusCode}");
      return null;
    }
  }catch(e){
    print("faild with error:${e.toString()}");
    return null;
  }
  }
}

