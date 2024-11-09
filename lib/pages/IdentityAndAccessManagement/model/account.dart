import 'dart:convert';

List<Account> accountFromJson(String str) =>
    List<Account>.from(
        json.decode(str).map((x) => Account.fromJson(x)));

String accountToJson(List<Account> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  int ? id;
  bool? isActive;
  String ? createdAt;
  String? emailAddress;
  String ? accountStatus;

  Account({
    this.id,
    this.isActive,
    this.createdAt,
    this.emailAddress,
    this.accountStatus,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      emailAddress: json['emailAddress'],
      accountStatus: json['accountStatus']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isActive': isActive,
      'createdAt': createdAt,
      'emailAddress': emailAddress,
      'accountStatus': accountStatus
    };
  }
}
