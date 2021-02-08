import 'dart:convert';
import 'package:ecomm_wholesaler/Models/WholeSalerProdcuts.dart';
import 'package:ecomm_wholesaler/helper/Apis.dart';
import 'package:ecomm_wholesaler/helper/Navigation.dart';
import 'package:ecomm_wholesaler/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'AddNewProducts.dart';

class SearchProduct extends StatefulWidget {
  final int id;

  const SearchProduct({Key key, this.id}) : super(key: key);
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  _listofitems(
      List<WholesalerProductData> products, BuildContext context, bool add) {
    return Container(
      height: MediaQuery.of(context).size.height * .9,
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      var rate = products[index].dealPrice;
                      return AlertDialog(
                        elevation: 20,
                        title: Text('Update Product'),
                        content: Container(
                          height: 180,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      await SharedPreferences.getInstance();
                                  var token = pref.getString('token');
                                  var res = await http.put(
                                      UPADTEPRODUCTS +
                                          products[index].id.toString(),
                                      headers: {
                                        "Authorization": token
                                      },
                                      body: {
                                        "deal_price ": rate.toString(),
                                      });
                                  print(res.body);
                                  if (res.statusCode == 200) {
                                    _btnController.success();
                                    Navigator.pop(context);
                                  } else {
                                    _btnController.reset();
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
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        products[index].product.imageUrl ??
                            'https://4.imimg.com/data4/LF/HH/MY-8952553/gym-capsule-250x250.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * .5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            maxLines: 5,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: products[index].product.title + "\n",
                                  style: TextStyle(
                                    color: black,
                                  ),
                                ),
                                TextSpan(
                                  text: products[index].product.manufacturer +
                                      "\n",
                                  style: TextStyle(
                                    color: grey,
                                  ),
                                ),
                                TextSpan(
                                  text: products[index].product.packSize + "\n",
                                  style: TextStyle(
                                    color: grey,
                                  ),
                                ),
                                TextSpan(
                                  text: "₹" +
                                      products[index].dealPrice.toString(),
                                  style: TextStyle(
                                    color: black,
                                  ),
                                ),
                                TextSpan(
                                    text: " ₹" +
                                        products[index].mrp.toString() +
                                        "\t",
                                    style: TextStyle(
                                        color: grey,
                                        decoration:
                                            TextDecoration.lineThrough)),
                              ],
                            ),
                          ),
                          // Container(
                          //   height: 30,
                          //   width: 75,
                          //   decoration: BoxDecoration(
                          //       color: white,
                          //       borderRadius:
                          //           BorderRadius.circular(8),
                          //       border: Border.all(color: blue)),
                          //   child: Center(
                          //       child: Row(
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.spaceEvenly,
                          //     children: <Widget>[
                          //       Provider.of<ProductModel>(context,
                          //                       listen: false)
                          //                   .getQuanity(
                          //                       products[index].id) ==
                          //               0
                          //           ? Container()
                          //           : InkWell(
                          //               onTap: () async {

                          //                 Provider.of<ProductModel>(
                          //                         context,
                          //                         listen: false)
                          //                     .removeItem(
                          //                         products[index]);
                          //                 await addToCart(
                          //                     products[index].id,
                          //                     Provider.of<ProductModel>(
                          //                             context,
                          //                             listen: false)
                          //                         .getQuanity(
                          //                             products[index]
                          //                                 .id));
                          //               },
                          //               child: Icon(
                          //                 Icons.remove,
                          //                 color: blue,
                          //               ),
                          //             ),
                          //       Provider.of<ProductModel>(context,
                          //                       listen: false)
                          //                   .getQuanity(
                          //                       products[index].id) ==
                          //               0
                          //           ? Text(
                          //               'ADD',
                          //               style: TextStyle(color: blue),
                          //             )
                          //           : Text(
                          //               Provider.of<ProductModel>(
                          //                       context,
                          //                       listen: false)
                          //                   .getQuanity(
                          //                       products[index].id)
                          //                   .toString(),
                          //               style: TextStyle(color: blue),
                          //             ),
                          //       InkWell(
                          //         onTap: () async {

                          //           // Provider.of<ProductModel>(context,
                          //           //         listen: false)
                          //           //     .addTaskInList(
                          //           //         products[index]);
                          //           // await addToCart(
                          //           //     products[index].id,
                          //           //     Provider.of<ProductModel>(
                          //           //             context,
                          //           //             listen: false)
                          //           //         .getQuanity(
                          //           //             products[index].id));
                          //         },
                          //         child: Icon(
                          //           Icons.add,
                          //           color: blue,
                          //         ),
                          //       ),
                          //     ],
                          //   )),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List<WholesalerProductData>> _getAllPosts() async {
    print('id' + widget.id.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var response = await http.get(PRODUCTS + widget.id.toString(),
        headers: {"Authorization": token});
    print("body" + response.body);
    WholesalerProductModel products =
        WholesalerProductModel.fromJson(json.decode(response.body));
    print('object');
    return products.data;
  }

  String search = '';
  bool s = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Products'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_circle,
              ),
              tooltip: 'Add New Product',
              onPressed: () => changeScreen(context, AddNewProduct(id:widget.id)),
            )
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         height: 50,
              //         width: MediaQuery.of(context).size.width * .95,
              //         decoration: BoxDecoration(
              //             color: white,
              //             borderRadius: BorderRadius.all(Radius.circular(10))),
              //         child: TextField(
              //           onTap: () {
              //             setState(() {
              //               s = true;
              //             });
              //           },
              //           onChanged: (val) {
              //             setState(() {
              //               search = val;
              //             });
              //           },
              //           decoration: InputDecoration(
              //               prefixIcon: IconButton(
              //                   icon: Icon(
              //                     Icons.arrow_back_ios,
              //                     color: grey,
              //                   ),
              //                   onPressed: () => Navigator.of(context).pop()),
              //               suffixIcon: s == true
              //                   ? IconButton(
              //                       icon: Icon(Icons.cancel),
              //                       onPressed: () => Navigator.pop(context))
              //                   : null,
              //               hintText: 'Search for Products',
              //               border: InputBorder.none),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              FutureBuilder(
                  future: _getAllPosts(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      print(snapshot.data);
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Column(
                        children: <Widget>[
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(20),
                          //     child: Container(
                          //       height: 20,
                          //       child: Padding(
                          //         padding:
                          //             const EdgeInsets.only(left: 10.0, right: 10),
                          //         child: Row(
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: <Widget>[
                          //             Text(
                          //               "Search result : " +
                          //                   snapshot.data.length.toString() +
                          //                   " items",
                          //               style: TextStyle(
                          //                   color: black,
                          //                   fontSize: 15,
                          //                   fontWeight: FontWeight.w500),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          _listofitems(snapshot.data, context, true)
                        ],
                      );
                    }
                  })
            ],
          ),
        )));
  }
}
