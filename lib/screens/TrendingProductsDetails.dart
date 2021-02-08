import 'dart:convert';

import 'package:ecomm_wholesaler/Models/Category.dart';
import 'package:ecomm_wholesaler/Models/TrendingProducts.dart';
import 'package:ecomm_wholesaler/Models/UserModel.dart';
import 'package:ecomm_wholesaler/helper/Apis.dart';
import 'package:ecomm_wholesaler/helper/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrendingProductDetails extends StatefulWidget {
  final CategoryData category;

  const TrendingProductDetails({Key key, this.category}) : super(key: key);
  @override
  _TrendingProductDetailsState createState() => _TrendingProductDetailsState();
}

class _TrendingProductDetailsState extends State<TrendingProductDetails> {
  Future<List<TrendingData>> getProducts() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    var res = await http.get(
      TRENDING + widget.category.id.toString(),
      headers: {"Authorization": token},
    );
    if (res.statusCode == 200) {
      TrendingProducts trendingProducts =
          TrendingProducts.fromJson(json.decode(res.body));
      return trendingProducts.data;
    } else {
      List<TrendingData> t = [];
      return t;
    }
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Products'),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TrendingData>> products) {
          switch (products.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              return ListView.separated(
                itemCount: products.data.length == 0 ? 1 : products.data.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 2,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  if (products.data.length != 0) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: GestureDetector(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                var rate = products.data[index].mrp;
                                return AlertDialog(
                                  elevation: 20,
                                  title: Text('Update Product'),
                                  content: Container(
                                    height: 180,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
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
                                            var user = pref.getString('user');
                                            UserData u = UserData.fromJson(
                                                json.decode(user));
                                            var res =
                                                await http.post(UPDATETRENDING,
                                                    // products.data[index].id
                                                    //     .toString(),
                                                    headers: {
                                                  "Authorization": token
                                                }, body: {
                                              "product_id": products
                                                  .data[index].id
                                                  .toString(),
                                              "wholesaler_id": u.id.toString(),
                                              "deal_price": rate.toString(),
                                            });
                                            print(res.body);
                                            if (res.statusCode == 200) {
                                              _btnController.success();

                                              Navigator.pop(context);
                                              setState(() {});
                                            } else {
                                              print('object');
                                              setState(() {});
                                              Fluttertoast.showToast(
                                                  msg: 'Product Already Exists',
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  backgroundColor: red,
                                                  textColor: white,
                                                  timeInSecForIosWeb: 10);
                                              _btnController.reset();
                                              Navigator.pop(context);
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
                        child: SizedBox(
                          // height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  products.data[index].imageUrl ??
                                      'https://4.imimg.com/data4/LF/HH/MY-8952553/gym-capsule-250x250.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                // height: 120,
                                width: MediaQuery.of(context).size.width -150,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      maxLines: 10,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: products.data[index].title +
                                                "\n",
                                            style: TextStyle(
                                              color: black,
                                            ),
                                          ),
                                          TextSpan(
                                            text: products.data[index]
                                                        .manufacturer.length ==
                                                    0
                                                ? ""
                                                : (products.data[index]
                                                        .manufacturer +
                                                    "\n"),
                                            style: TextStyle(
                                              color: grey,
                                            ),
                                          ),
                                          TextSpan(
                                            text: products.data[index].packSize
                                                            .length ==
                                                        0 ||
                                                    products.data[index]
                                                            .packSize.length ==
                                                        null
                                                ? " "
                                                : "${products.data[index].packSize}\n",
                                            style: TextStyle(
                                              color: grey,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "₹" +
                                                products.data[index].mrp
                                                    .toString(),
                                            style: TextStyle(
                                              color: black,
                                            ),
                                          ),
                                          TextSpan(
                                              text: " ₹" +
                                                  products.data[index].sellingPrice
                                                      .toString() +
                                                  "\t",
                                              style: TextStyle(
                                                  color: grey,
                                                  decoration: TextDecoration
                                                      .lineThrough)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: Text('No Product Available')));
                  }
                },
              );
              break;
            default:
              return Text('Something went wrong');
          }
        },
      ),
    );
  }
}
