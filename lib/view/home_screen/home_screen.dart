// ignore_for_file: prefer_const_constructors

import 'package:fake_store_listofmap/controller/cart_screen_controller.dart';
import 'package:fake_store_listofmap/controller/home_screen_controller.dart';
import 'package:fake_store_listofmap/global_widgets/reusable_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().getProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeScreenState = context.watch<HomeScreenController>();

    return Scaffold(
      body: homeScreenState.isLoading
          ? Center(
              child: ReusableLoadingIndicator(),
            )
          : ListView.builder(
              itemCount: homeScreenState.productsList.length,
              itemBuilder: (context, index) => ListTile(
                leading: Image.network(
                    homeScreenState.productsList[index].image ?? ""),
                title: Text(homeScreenState.productsList[index].title ?? ""),
                subtitle:
                    Text(homeScreenState.productsList[index].price.toString()),
                trailing: IconButton(
                    onPressed: () {
                      context.read<CartScreenController>().addToCart(
                          homeScreenState.productsList[index], context);
                    },
                    icon: Icon(Icons.shopping_cart_checkout)),
              ),
            ),
    );
  }
}
