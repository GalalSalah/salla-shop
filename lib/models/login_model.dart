import 'package:flutter/material.dart';

class ShopLoginModel {
  // ShopLoginModel({
  //   required this.status,
  //   required this.message,
  //   required this.data,
  // });

   bool status;
   String message;
   Data data;

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data?.toJson();
    return _data;
  }
}

class Data {
  Data({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.image,
    @required this.points,
    @required this.credit,
    @required this.token,
  });

    int id;
    String name;
    String email;
    String phone;
    String image;
    int points;
    int credit;
    String token;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['image'] = image;
    _data['points'] = points;
    _data['credit'] = credit;
    _data['token'] = token;
    return _data;
  }
}
