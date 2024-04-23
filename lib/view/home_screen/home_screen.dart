// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.star)),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(Icons.face)),
          )
        ],
      ),
      endDrawer: Drawer(),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Container(color: Colors.blueGrey)),
            UserAccountsDrawerHeader(
                otherAccountsPictures: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/20682311/pexels-photo-20682311/free-photo-of-sevilla-plaza-de-espana.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/1659435/pexels-photo-1659435.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"),
                  )
                ],
                currentAccountPictureSize: Size.fromRadius(50),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/20741822/pexels-photo-20741822/free-photo-of-a-person-standing-in-a-field-of-flowers.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"),
                ),
                accountName: Text("Name"),
                accountEmail: Text("Email ID")),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            )
          ],
        ),
      ),
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
