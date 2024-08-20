import 'dart:convert';

List<NotificationEntity> notificationFromJson(String str) =>
    List<NotificationEntity>.from(
        json.decode(str).map((x) => NotificationEntity.fromJson(x)));

String notificationToJson(List<NotificationEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationEntity {
  int? id;
  String? title;
  String? body;
  String ? createdAt;

  NotificationEntity({
    this.id,
    this.title,
    this.body,
    this.createdAt
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      createdAt: json['createdAt']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt,
    };
  }
}
