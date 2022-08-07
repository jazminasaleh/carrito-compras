import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final int price;
  final String img;

  Product(this.id, this.name, this.description, this.price, this.img);
}

class CartItem {
  final int id;
  final String name;
  final int price;
 // final String img;
  int quantity;
  

  CartItem(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      //required this.img, 
      });

  get totalPrice {
    return quantity * price;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      //'img': img
    };
  }
}
