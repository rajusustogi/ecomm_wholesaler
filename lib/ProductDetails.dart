import 'dart:convert';
import 'package:ecomm_wholesaler/LoginPage.dart';
import 'package:ecomm_wholesaler/Models/UserModel.dart';
import 'package:ecomm_wholesaler/helper/colors.dart';
import 'package:ecomm_wholesaler/screens/Details.dart';
import 'package:ecomm_wholesaler/helper/Navigation.dart';
import 'package:ecomm_wholesaler/screens/Invoice.dart';
import 'package:ecomm_wholesaler/screens/Products.dart';
import 'package:ecomm_wholesaler/screens/Trending.dart';
import 'package:ecomm_wholesaler/screens/completePackages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {
  final UserData user;

  const ProductDetails({Key key, this.user}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // Future<Null> _refreshLocalGallery() async {
  //   await new Future.delayed(const Duration(seconds: 2), () => setState(() {}));
  // }

  int _currentIndex = 0;
  final List<Widget> _children = [
    PendingOrderDetails(
      status: 'pending',
    ),
    CompleteOrder(),
    PendingOrderDetails(
      status: 'out of stock',
    ),
    Trending(),
    Invoice(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  UserData user;
  String name = '';
  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData u = UserData.fromJson(json.decode(prefs.getString('user')));
    setState(() {
      user = u;
      name = user.name;
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }
    final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          key: key,
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, selectedItemColor: blue,
          unselectedItemColor: grey, showUnselectedLabels: true, elevation: 20,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.watch_later),
              title: new Text('Pending'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.playlist_add_check),
              title: new Text('Accepted'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.signal_cellular_no_sim),
              title: new Text('out of stock'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.trending_up),
              title: new Text('Trending'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_download), title: Text('Invoice'))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.account_circle, size: 50, color: white),
                    Text(widget.user.name.toUpperCase(),
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Text(widget.user.email,
                        style: TextStyle(
                          color: white,
                        )),
                    Text(widget.user.mobileNo.toString(),
                        style: TextStyle(
                          color: white,
                        )),
                    Text(widget.user.storeName ?? '',
                        style: TextStyle(
                          color: white,
                        )),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                leading: Text('My Products'),
                onTap: () {
                  changeScreen(context, SearchProduct(id: user.id));
                },
              ),
              ListTile(
                  leading: Text('Logout'),
                  trailing: Icon(Icons.exit_to_app),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    changeScreenRepacement(context, LoginPage());
                  })
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(name.toUpperCase()),
          centerTitle: false,
        ),
        body: _children[_currentIndex]);
  }
}
