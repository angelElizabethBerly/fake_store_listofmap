// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fake_store_listofmap/controller/cart_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<CartScreenController>(
          builder: (context, providerObj, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: providerObj.cartList.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(
                                        providerObj.cartList[index].product
                                                .image ??
                                            "",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            providerObj.cartList[index].product
                                                    .title ??
                                                "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            providerObj
                                                .cartList[index].product.price
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              context
                                                  .read<CartScreenController>()
                                                  .deleteFromCart(index);
                                            },
                                            icon: Icon(Icons.delete)),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          CartScreenController>()
                                                      .decrementQty(index);
                                                },
                                                icon: Icon(Icons.remove)),
                                            Text(
                                              providerObj.cartList[index].qty
                                                  .toString(),
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          CartScreenController>()
                                                      .incrementQty(index);
                                                },
                                                icon: Icon(Icons.add))
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    decoration: BoxDecoration(color: Colors.amber),
                    child: Text(
                      providerObj.totalPrice.toStringAsFixed(2),
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
