class Favorite {
  int? id;
  int? userId;
  int? productId;
  String? createdAt;
  String? updatedAt;

  Favorite(
      {this.id, this.userId, this.productId, this.createdAt, this.updatedAt});

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
