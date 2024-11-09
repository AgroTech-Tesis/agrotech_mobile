import 'dart:convert';

import 'package:agrotech_mobile/environment/environment.const.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/account.dart';
import 'package:agrotech_mobile/pages/IdentityAndAccessManagement/model/signIn.dart';
import 'package:http/http.dart' as http;

class HttpSignInService {
  var proposal = http.Client();
  String urlService = "${localhost1}sign-in";

  Future<dynamic> signIn(SignInModel signIn) async {
    var uri = Uri.parse(urlService);
    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
        },
        body: jsonEncode(signIn));
    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    } else {
      return response.body;
    }
  }
}
