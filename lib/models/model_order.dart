class ModelOrder {
  Item? item;

  // ignore: non_constant_identifier_names
  String? order_date;

  // ignore: non_constant_identifier_names
  String? order_status;

  // ignore: non_constant_identifier_names
  String? order_number;

  // ignore: non_constant_identifier_names
  ModelOrder({this.item, this.order_date, this.order_status, this.order_number});

  factory ModelOrder.fromJson(Map<String, dynamic> json) {
    return ModelOrder(
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      order_date: json['order_date'],
      order_status: json['order_status'],
      order_number: json['order_number'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_date'] = order_date;
    data['order_status'] = order_status;
    data['order_number'] = order_number;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}

class Item {
  int? id;
  String? name;
  String? price;
  String? image;

  Item({this.id, this.name, this.price, this.image});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}
