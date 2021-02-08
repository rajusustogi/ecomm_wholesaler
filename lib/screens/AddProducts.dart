import 'dart:convert';

import 'package:ecomm_wholesaler/Models/Category.dart';
import 'package:ecomm_wholesaler/helper/Apis.dart';
import 'package:ecomm_wholesaler/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddProduct extends StatefulWidget {
  @override
  AddProductState createState() {
    return AddProductState();
  }
}

class AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String mfg;
  String composition;
  String size;
  String mrp;
  String rate;
  List<CategoryData> category;

  CategoryData selectedValue;
  categoryget() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    var res = await http.get(
      CATEGORY,
      headers: {"Authorization": token},
    );
    print(res.body);
    if (res.statusCode == 200) {
      Category cat = Category.fromJson(json.decode(res.body));
      setState(() {
        category = cat.data;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    categoryget();
    super.initState();
  }

  bool isLoading = true;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Products')),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text('ENTER PRODUCT DETAILS',
                            style: Theme.of(context).textTheme.headline5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              // icon: const Icon(Icons.person),
                              hintText: 'Enter Product name',
                              labelText: 'Product Name*',
                            ),
                            onSaved: (val) {
                              setState(() {
                                name = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Cannot be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              // icon: const Icon(Icons.person),
                              hintText: 'Enter Mfg',
                              labelText: 'Mfg*',
                            ),
                            onSaved: (val) {
                              setState(() {
                                mfg = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Cannot be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              // icon: const Icon(Icons.person),
                              hintText: 'Enter composition',
                              labelText: 'Composition',
                            ),
                            onSaved: (val) {
                              setState(() {
                                composition = val;
                              });
                            },
                            //  validator: (val) {
                            //     if (val.isEmpty) {
                            //       return 'Cannot be empty';
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              // icon: const Icon(Icons.person),
                              hintText: 'Enter pack size',
                              labelText: 'pack size*',
                            ),
                            onSaved: (val) {
                              setState(() {
                                size = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Cannot be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              // icon: const Icon(Icons.phone),
                              hintText: 'Enter a MRP',
                              labelText: 'MRP*',
                            ),
                            onSaved: (val) {
                              setState(() {
                                mrp = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Cannot be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              // icon: const Icon(Icons.calendar_today),
                              hintText: 'Enter deal rate',
                              labelText: 'Deal Rate*',
                            ),
                            onSaved: (val) {
                              setState(() {
                                rate = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Cannot be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: DropdownButtonFormField(
                            autovalidate: true,
                            decoration: InputDecoration(labelText: 'Category'),
                            items: category.map((CategoryData area) {
                              return DropdownMenuItem<CategoryData>(
                                  value: area,
                                  child: Text(area.title.toUpperCase(),
                                      style: TextStyle(fontSize: 15)));
                            }).toList(),
                            // value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },

                            validator: (value) {
                              if (value == null) {
                                return 'please select a Category';
                              }
                              return null;
                            },
                            isExpanded: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RoundedLoadingButton(
                            color: green,
                            controller: _btnController,
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate() && selectedValue!=null) {
                                _formKey.currentState.save();

                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                var token = pref.getString('token');
                                var res =
                                    await http.post(ADDPRODUCTS, headers: {
                                  "authorization": token
                                }, body: {
                                  "title": name,
                                  "manufacturer": mfg,
                                  "pack_size": size.toString(),
                                  "deal_price": rate.toString(),
                                  "mrp": mrp.toString(),
                                  "composition": composition ?? '',
                                  "category_id": selectedValue.id.toString()
                                });
                                print(res.body);
                                if(res.statusCode==200){
                                  _btnController.success();
                                }
                              } else {
                                _btnController.reset();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
