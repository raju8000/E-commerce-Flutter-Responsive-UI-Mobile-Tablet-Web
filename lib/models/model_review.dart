class ModelReview {
  // ignore: non_constant_identifier_names
  String? date_created;

  // ignore: non_constant_identifier_names
  String? date_created_gmt;
  String? email;
  int? id;
  String? name;

  // ignore: non_constant_identifier_names
  int? product_id;
  int? rating;
  String? review;
  bool? verified;

  // ignore: non_constant_identifier_names
  ModelReview({this.date_created, this.date_created_gmt, this.email, this.id, this.name, this.product_id, this.rating, this.review, this.verified});

  factory ModelReview.fromJson(Map<String, dynamic> json) {
    return ModelReview(
      date_created: json['date_created'],
      date_created_gmt: json['date_created_gmt'],
      email: json['email'],
      id: json['id'],
      name: json['name'],
      product_id: json['product_id'],
      rating: json['rating'],
      review: json['review'],
      verified: json['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_created'] = date_created;
    data['date_created_gmt'] = date_created_gmt;
    data['email'] = email;
    data['id'] = id;
    data['name'] = name;
    data['product_id'] = product_id;
    data['rating'] = rating;
    data['review'] = review;
    data['verified'] = verified;
    return data;
  }
}
