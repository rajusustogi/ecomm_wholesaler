import 'dart:async';
import 'dart:convert';

import 'package:ecomm_wholesaler/Models/ProductModel.dart';
import 'package:ecomm_wholesaler/helper/Apis.dart';
import 'package:ecomm_wholesaler/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

Future<List<ProductData>> getProducts(status) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token');
  var response = await http.get(ORDERS, headers: {"authorization": token});
  List<ProductData> productData = [];

  print(response.body);
  if (response.statusCode == 200) {
    ProductModel productModel =
        ProductModel.fromJson(json.decode(response.body));
    productData = productModel.data;
    switch (status) {
      case 'pending':
        return productData
            .where((element) =>
                element.availability == 'pending' ||
                element.availability == 'revised rate')
            .toList();

        break;
      case 'complete':
        return productData
            .where((element) => element.availability == 'complete')
            .toList();
        break;
      case 'out of stock':
        return productData
            .where((element) =>
                element.availability == 'out of stock' ||
                element.availability == 'partial')
            .toList();
        break;
      default:
    }
  } else {
    return productData;
  }
}

class PendingOrderDetails extends StatefulWidget {
  final status;

  const PendingOrderDetails({Key key, this.status}) : super(key: key);
  @override
  _PendingOrderDetailsState createState() => _PendingOrderDetailsState();
}

class _PendingOrderDetailsState extends State<PendingOrderDetails> {
  String code;

  void _launchMapsUrl(String latitude, String longitude) async {
    print(latitude);
    final url = 'https://www.google.com/maps?q=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Null> _refreshLocalGallery() async {
    await new Future.delayed(const Duration(seconds: 1), () => setState(() {}));
  }

  // getQuantity(ProductData data) {
  //   int total = 0;
  //   for (int i = 0; i < data.products.length; i++) {
  //     total = total + data.products[i].noOfUnits;
  //   }
  //   return total;
  // }

  getColor() {
    switch (widget.status) {
      case 'pending':
        return Colors.yellowAccent;

        break;
      case 'complete':
        return Colors.green;
        break;
      case 'out of stock':
        return Colors.red;
        break;
      default:
        return Colors.yellowAccent;
        break;
    }
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " OUT OF STOCK",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget slideRightBackground() {
    return Container(
      color: green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            widget.status == 'pending'
                ? Icon(
                    Icons.edit,
                    color: Colors.white,
                  )
                : Container(),
            Text(
              widget.status == 'pending' ? "Accepted Order" : '',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.status);
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: _refreshLocalGallery,
      child: FutureBuilder(
        future: getProducts(widget.status),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length == 0 ? 1 : snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data.length == 0) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text('No Order Available'),
                    ),
                  );
                }
                return Dismissible(
                  key: Key(snapshot.data[index].id.toString()),
                  background: slideRightBackground(),
                  secondaryBackground: slideLeftBackground(),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd &&
                        widget.status == 'pending') {
                      if (snapshot.data[index].availability == "revised rate") {
                        Fluttertoast.showToast(
                            msg: 'Waiting for admin Acceptation',
                            toastLength: Toast.LENGTH_LONG,
                            backgroundColor: red,
                            textColor: white,
                            timeInSecForIosWeb: 10);
                      } else {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        var token = pref.getString('token');
                        var res = await http.put(
                            UPDATEORDER + snapshot.data[index].id.toString(),
                            headers: {
                              "authorization": token
                            },
                            body: {
                              "availability": "complete",
                            });
                        if (res.statusCode != 200) {
                          Fluttertoast.showToast(
                              msg: 'Something went wrong',
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: red,
                              textColor: white,
                              timeInSecForIosWeb: 10);
                        } else {
                          setState(() {
                            snapshot.data.remove(snapshot.data[index]);
                          });
                        }

                        // setState(() {});
                        print(token);
                        print(res.body);
                      }
                    } else if (direction == DismissDirection.endToStart &&
                        widget.status == 'pending') {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      var token = pref.getString('token');
                      var res = await http.put(
                          UPDATEORDER + snapshot.data[index].id.toString(),
                          headers: {
                            "authorization": token
                          },
                          body: {
                            "availability": "out of stock",
                          });
                      print(token);
                      print(res.body);
                      setState(() {
                        snapshot.data.remove(snapshot.data[index]);
                      });
                      return true;
                    }
                  },
                  child: GestureDetector(
                    // onTap: () => changeScreen(
                    //     context,
                    //     Description(
                    //       order: snapshot.data[index],
                    //     )),
                    onLongPress: () {
                      code = snapshot.data[index].requiredQuantity.toString();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            var rate = snapshot
                                .data[index].wholesalerProduct.dealPrice;
                            return AlertDialog(
                              elevation: 20,
                              title: Text('Update Product'),
                              content: Container(
                                height: 180,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      initialValue: code,
                                      onChanged: (val) {
                                        setState(() {
                                          code = val;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Quantity',
                                          border: OutlineInputBorder()),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      initialValue: rate.toString(),
                                      onChanged: (val) {
                                        setState(() {
                                          rate = val;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Deal Rate',
                                          border: OutlineInputBorder()),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    RoundedLoadingButton(
                                      controller: _btnController,
                                      onPressed: () async {
                                        SharedPreferences pref =
                                            await SharedPreferences
                                                .getInstance();
                                        var token = pref.getString('token');
                                        if (rate ==
                                            snapshot.data[index]
                                                .wholesalerProduct.dealPrice) {
                                          var res = await http.put(
                                              UPDATEORDER +
                                                  snapshot.data[index].id
                                                      .toString(),
                                              headers: {
                                                "Authorization": token
                                              },
                                              body: {
                                                "available_quantity":
                                                    code.toString(),
                                                "availability": "partial",
                                                // "order_status": "received"
                                              });
                                          print(token);
                                          print(res.body);
                                          if (res.statusCode == 200) {
                                            _btnController.success();
                                            setState(() {
                                              snapshot.data
                                                  .remove(snapshot.data[index]);
                                            });
                                            Navigator.pop(context);
                                          } else {
                                            _btnController.error();
                                            Fluttertoast.showToast(
                                                msg: 'Something went wrong',
                                                toastLength: Toast.LENGTH_LONG,
                                                backgroundColor: red,
                                                textColor: white,
                                                timeInSecForIosWeb: 10);
                                            Timer(Duration(seconds: 5),
                                                () => _btnController.reset());
                                          }
                                        } else {
                                          print('deal updated');
                                          var res = await http.put(
                                              UPDATEORDER +
                                                  snapshot.data[index].id
                                                      .toString(),
                                              headers: {
                                                "Authorization": token
                                              },
                                              body: {
                                                "available_quantity":
                                                    code.toString(),
                                                "availability": "revised rate",
                                                "new_price": rate.toString()
                                                // "order_status": "received"
                                              });
                                          print("DEAL update  ...." + res.body);
                                          if (res.statusCode == 200) {
                                            _btnController.success();
                                            setState(() {
                                              snapshot.data[index]
                                                      .availability =
                                                  "revised rate";
                                            });
                                            Navigator.pop(context);
                                          } else {
                                            _btnController.error();
                                            Fluttertoast.showToast(
                                                msg: 'Something went wrong',
                                                toastLength: Toast.LENGTH_LONG,
                                                backgroundColor: red,
                                                textColor: white,
                                                timeInSecForIosWeb: 10);
                                            Timer(Duration(seconds: 5),
                                                () => _btnController.reset());
                                          }
                                        }
                                      },
                                      height: 40,
                                      width: 150,
                                      color: green,
                                      child: Text(
                                        "SUBMIT",
                                        style: TextStyle(color: white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 120,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: white,
                          boxShadow: [
                            new BoxShadow(
                                color: snapshot.data[index].availability ==
                                        "revised rate"
                                    ? blue
                                    : getColor(),
                                blurRadius: 5.0,
                                offset: Offset(1, 1),
                                spreadRadius: 3),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: size.width * 0.60,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            snapshot.data[index].product.title
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                          snapshot.data[index].wholesalerProduct
                                              .product.manufacturer
                                              .toString()
                                           ,
                                          style: TextStyle(color: grey),
                                          overflow: TextOverflow.ellipsis)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Text("Pack Size: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            snapshot
                                                .data[index]
                                                .wholesalerProduct
                                                .product
                                                .packSize
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text("MRP: ₹",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(snapshot.data[index]
                                            .wholesalerProduct.product.mrp
                                            .toString())
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text("Deal Rate: ₹",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(snapshot.data[index]
                                            .wholesalerProduct.dealPrice
                                            .toString())
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: size.width * 0.3,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: size.width * 0.3,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data[index]
                                                .wholesalerProduct
                                                .product
                                                .imageUrl),
                                            fit: BoxFit.contain)),
                                  ),
                                  Text(
                                    'Qty - ${snapshot.data[index].requiredQuantity.toString()}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Container(
              child: Center(
                child: Text('LOADING...'),
              ),
            );
          }
        },
      ),
    );
  }
}
