import 'package:fake_store_listofmap/model/product_res_model.dart';

class CartModel {
  ProductResModel product;
  int qty;
  CartModel({required this.product, this.qty = 1});
}
