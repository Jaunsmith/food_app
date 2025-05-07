// This is need to be created in other to make the data globally available and also to be able to store datra back to the server
// THe product model is added in other to be able to access the product controller from the cart controller
import 'package:food_app/models/main_food_model.dart';

class CartItemsModel {
  int? id;
  String? name;
  int? price;
  String? img;
  String? createdAt;
  String? updatedAt;
  int? quantity;
  bool? isExist;
  String? time;
  ProductsModel? productsModel;

  CartItemsModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.createdAt,
    this.updatedAt,
    this.quantity,
    this.time,
    this.isExist,
    this.productsModel,
  });

  // Converting a Json to an object...
  CartItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    time = json['time'];
    isExist = json['isExist'];
    // It need to be converted to a json ..
    productsModel =
        json['productsModel'] != null
            ? ProductsModel.fromJson(json['productsModel'])
            : null;
  }

  // converting from object to Json
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'img': this.img,
      'quantity': this.quantity,
      'isExit': this.isExist,
      'time': this.time,
      'productsModel': productsModel!.toJson(),
    };
  }
}
