import 'dart:convert';

import 'package:flutter/services.dart';
import '../models/model_address.dart';
import '../models/model_attribute.dart';
import '../models/model_category.dart';
import '../models/model_order.dart';
import '../models/model_product.dart';

Future<String> loadContentAsset(String path) async {
  return await rootBundle.loadString(path);
}

Future<List<ModelCategory>> loadCategory() async {
  String jsonString = await loadContentAsset('assets/shophop_data/category.json');
  final jsonResponse = json.decode(jsonString);
  return (jsonResponse as List).map((i) => ModelCategory.fromJson(i)).toList();
}

Future<List<ModelProduct>> loadProducts() async {
  String jsonString = await loadContentAsset('assets/shophop_data/products.json');
  final jsonResponse = json.decode(jsonString);
  return (jsonResponse as List).map((i) => ModelProduct.fromJson(i)).toList();
}

Future<List<ModelProduct>> loadCartProducts() async {
  String jsonString = await loadContentAsset('assets/shophop_data/cart_products.json');
  final jsonResponse = json.decode(jsonString);
  return (jsonResponse as List).map((i) => ModelProduct.fromJson(i)).toList();
}

Future<ModelAttributes> loadAttributes() async {
  String jsonString = await loadContentAsset('assets/shophop_data/attributes.json');
  final jsonResponse = json.decode(jsonString);
  return ModelAttributes.fromJson(jsonResponse);
}

Future<List<ModelAddress>> loadAddresses() async {
  String jsonString = await loadContentAsset('assets/shophop_data/address.json');
  final jsonResponse = json.decode(jsonString);
  return (jsonResponse as List).map((i) => ModelAddress.fromJson(i)).toList();
}

Future<List<ModelOrder>> loadOrders() async {
  String jsonString = await loadContentAsset('assets/shophop_data/orders.json');
  final jsonResponse = json.decode(jsonString);
  return (jsonResponse as List).map((i) => ModelOrder.fromJson(i)).toList();
}

Future<List<String>> loadBanners() async {
  List<ModelProduct> products = await loadProducts();
  List<String> banner = [];

  products.forEach((product) {
    if (product.images!.isNotEmpty) {
      banner.add("assets/images/shopx/img/products${product.images![0].src!}");
    }
  });
  return banner;
}


