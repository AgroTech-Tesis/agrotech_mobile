import 'dart:convert';

import 'package:agrotech_mobile/environment/environment.const.dart';
import 'package:agrotech_mobile/pages/IrrigationManagement/model/notification.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  NotificationService();
  String urlService = "${localhost}notification";

  Future<NotificationEntity?> createIrrigation(NotificationEntity irrigation) async {
    var uri = Uri.parse(urlService);
    final response = await http.post(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    }, body: jsonEncode(irrigation));

    if (response.statusCode == 200) {
      return NotificationEntity.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}