
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Constants {
  static const String BASE_URL = 'https://fcm.googleapis.com/fcm/send';
  static const String KEY_SERVER = 'BKiLeKSgHA0CSvDsEgzd5jqQEKq3glfr8g8SeqJdlSWI-MrVRhOaSS6SNZI8AMpX8jJU7ra3Ab_51zm--a-2vT8';
  static const String SENDER_ID = '494818832624';
}

class NotificacionService{
  Future<bool> pusherNotificaation({
    required String title,
    required String body,
    required String token
  }) async {
    print(token);
    print(title);
    print(body);
    Map<String, dynamic> payload = {
      'to': token,
      'notification': {
        'priority': 'high',
        'title': title,
        'body': body,
        'sound': 'default',
      }
    };
    String dataNotifications = jsonEncode(payload);
    var response = await http.post(
      Uri.parse(Constants.BASE_URL),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=${Constants.KEY_SERVER}',
      },
      body: dataNotifications
    );
    debugPrint('Response: ${response.body}');
    return true ; 
  }
}