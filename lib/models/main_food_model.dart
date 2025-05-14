class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  int? _stars;
  late List<ProductsModel> _products;

  List<ProductsModel> get products => _products;

  Product({
    required totalSize,
    required typeId,
    required offset,
    required products,
    required stars,
  }) {
    _totalSize = totalSize;
    _typeId = typeId;
    _offset = offset;
    _stars = stars;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    _stars = json['stars'];
    if (json['products'] != null) {
      _products = <ProductsModel>[];
      json['products'].forEach((e) {
        _products.add(ProductsModel.fromJson(e));
      });
    }
  }
}

class ProductsModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductsModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stars,
    this.img,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.typeId,
  });

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'img': img,
      'location': location,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'type_id': typeId,
    };
  }
}
