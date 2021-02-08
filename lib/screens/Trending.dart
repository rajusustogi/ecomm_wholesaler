import 'dart:convert';
import 'package:ecomm_wholesaler/helper/Navigation.dart';
import 'package:ecomm_wholesaler/helper/colors.dart';
import 'package:http/http.dart' as http;
import 'package:ecomm_wholesaler/Models/Category.dart';
import 'package:ecomm_wholesaler/helper/Apis.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TrendingProductsDetails.dart';

class Trending extends StatefulWidget {
  Trending({Key key}) : super(key: key);

  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  Future<List<CategoryData>> categoryget() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString('token');
    var res = await http.get(
      CATEGORY,
      headers: {"Authorization": token},
    );
    print(res.body);
    if (res.statusCode == 200) {
      Category cat = Category.fromJson(json.decode(res.body));
      // setState(() {
      //   category = cat.data;
      //   isLoading = false;
      // });
      return cat.data;
    } else {
      List<CategoryData> c = [];
      return c;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: categoryget(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CategoryData>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

              break;
            case ConnectionState.done:
              return Container(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 2,
                    );
                  },
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snapshot.data[index].title),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        changeScreen(
                            context,
                            TrendingProductDetails(
                                category: snapshot.data[index]));
                      },
                    );
                  },
                ),
              );

              break;
            default:
              return Container(
                child: Center(child: Text('Something went wrong')),
              );
          }
        },
      ),
    );
  }
}
