class BasketProduct {
  int? id;
  int? basketId;
  int? productId;
  int? count;
  int? price;
  int? pricefull;
  String? createdAt;
  String? updatedAt;
  int? offprice;

  BasketProduct(
      {this.id,
        this.basketId,
        this.productId,
        this.count,
        this.price,
        this.pricefull,
        this.createdAt,
        this.updatedAt,
        this.offprice});

  BasketProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    basketId = json['basket_id'];
    productId = json['product_id'];
    count = json['count'];
    price = json['price'];
    pricefull = json['pricefull'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    offprice = json['offprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['basket_id'] = basketId;
    data['product_id'] = productId;
    data['count'] = count;
    data['price'] = price;
    data['pricefull'] = pricefull;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['offprice'] = offprice;
    return data;
  }
}
