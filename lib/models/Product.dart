class Product {
  int? id;
  String? name;
  int? price;
  String? propertise;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  int? number;
  int? deleteStatuse;
  int? counter;
  String? image;

  Product(
      {this.id,
        this.name,
        this.price,
        this.propertise,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.number,
        this.deleteStatuse,
        this.counter,
        this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    propertise = json['propertise'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    number = json['number'];
    deleteStatuse = json['DeleteStatuse'];
    counter = json['counter'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['propertise'] = propertise;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['number'] = number;
    data['DeleteStatuse'] = deleteStatuse;
    data['counter'] = counter;
    data['image'] = image;
    return data;
  }
}
