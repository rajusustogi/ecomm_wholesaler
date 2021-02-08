import 'dart:convert';
import 'package:ecomm_wholesaler/helper/colors.dart';
import 'package:http/http.dart' as http;
import 'package:ecomm_wholesaler/Models/InvoiceModel.dart';
import 'package:ecomm_wholesaler/helper/Apis.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteOrder extends StatefulWidget {
  CompleteOrder({Key key}) : super(key: key);

  @override
  _CompleteOrderState createState() => _CompleteOrderState();
}

Future<List<Products>> getOrders() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token');

  var response =
      await http.get(ACCEPTEDORDERS, headers: {"authorization": token});
  List<Products> product = [];
  print("hello" + response.body);
  if (response.statusCode == 200) {
    InvoiceModel productModel =
        InvoiceModel.fromJson(json.decode(response.body));
    for (var i in productModel.data) {
      if (i.pickupDate == null) {
        for (var j in i.products) {
          product.add(j);
        }
      }
    }
    return product;
  }
  return null;
}

class _CompleteOrderState extends State<CompleteOrder> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getOrders(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.done:
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: white,
                      boxShadow: [
                        new BoxShadow(
                            color: green,
                            blurRadius: 5.0,
                            offset: Offset(1, 1),
                            spreadRadius: 3),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Container(
                                width: size.width * 0.5,
                                child: Text(
                                    snapshot.data[index].title
                                        .toString()
                                        .toUpperCase(),
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Container(
                                width: size.width * 0.5,
                                child: Text(
                                  snapshot.data[index].manufacturer.toString(),
                                  style: TextStyle(color: grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Container(
                                width: size.width * 0.5,
                                child: Row(
                                  children: <Widget>[
                                    Text("Pack Size: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        snapshot.data[index].packSize
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: <Widget>[
                                  Text("rate: ₹",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(snapshot.data[index].rate.toString())
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              height: 100,
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data[index].imageUrl),
                                      fit: BoxFit.contain)),
                            ),
                            Text(
                              'Qty - ${snapshot.data[index].noOfUnits.toString()}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
            break;
          default:
            return Center(
              child: Text('No Order'),
            );
        }
      },
    );
  }
}
