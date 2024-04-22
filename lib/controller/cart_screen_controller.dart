import 'dart:developer';

import 'package:fake_store_listofmap/model/cart_screen_model.dart';
import 'package:fake_store_listofmap/model/product_res_model.dart';
import 'package:fake_store_listofmap/view/cart_screen/cart_screen.dart';
import 'package:flutter/material.dart';

class CartScreenController with ChangeNotifier {
  List<CartModel> cartList = [];

  addToCart(ProductResModel product, BuildContext context) {
    final isAlreadyInCart =
        cartList.any((element) => element.product.id == product.id);
    if (isAlreadyInCart) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CartScreen()));
      log("Already in cart");
    } else {
      cartList.add(CartModel(product: product));
    }
    notifyListeners();
  }

  deleteFromCart(int index) {
    cartList.removeAt(index);
    notifyListeners();
  }

  incrementQty(int index) {
    cartList[index].qty = cartList[index].qty + 1;
    notifyListeners();
  }

  decrementQty(int index) {
    if (cartList[index].qty > 1) {
      cartList[index].qty = cartList[index].qty - 1;
    }
    notifyListeners();
  }
}
