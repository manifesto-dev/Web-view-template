import 'dart:convert';

class NotificationMessage {
  Data? data;
  NotificationMessage({this.data});
  NotificationMessage.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? Data.fromJson(jsonDecode(json['data'])) : null;
  }
}

class Data {
  String? title;
  String? message;

  Data({this.title, this.message});
  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
  }
}
