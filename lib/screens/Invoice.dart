import 'dart:convert';
import 'package:ecomm_wholesaler/Models/InvoiceModel.dart';
import 'package:ecomm_wholesaler/helper/Apis.dart';
import 'package:ecomm_wholesaler/helper/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<InvoiceModel> invoice() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString('token');
  var response = await http.get(INVOICE, headers: {"authorization": token});
  // List<InvoiceData> productData = [];
  print("hello" + response.body);
  if (response.statusCode == 200) {
    InvoiceModel productModel =
        InvoiceModel.fromJson(json.decode(response.body));
    // productData = productModel.data;
    return productModel;
  }
}

class Invoice extends StatefulWidget {
  Invoice({Key key}) : super(key: key);

  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  amount(List<Products> products) {
    var tprice = 0.0;
    for (var i in products) {
      // print(i.amount.toString());
      tprice += double.parse(i.amount.toString());
    }
    return tprice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: invoice(),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final Size size = MediaQuery.of(context).size;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()),
              );

              break;
            case ConnectionState.done:
              return ListView.separated(
                  itemCount: snapshot.data.data.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                      child: Divider(
                        thickness: 10,
                      ),
                    );
                  },
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: size.width,
                                  color: amber,
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Pickup Id: ${snapshot.data.data[index].pickupId.toString()}",
                                      style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ))
                            ],
                          ),
                          Container(
                            width: size.width,
                            child: DataTable(
                                // columnSpacing: size.width * 0.15,
                                columns: <DataColumn>[
                                  DataColumn(label: Text('Product')),
                                  DataColumn(label: Text('Rate')),
                                  DataColumn(label: Text('Qty')),
                                  DataColumn(label: Text('Amount')),
                                ],
                                rows: snapshot.data.data[index].products
                                    .map<DataRow>((p) =>
                                        DataRow(selected: true, cells: [
                                          DataCell(Text(p.title.toString()),
                                              onTap: () {}),
                                          DataCell(
                                            Text(
                                              p.rate.toString(),
                                            ),
                                          ),
                                          DataCell(Text(p.noOfUnits.toString())),
                                          DataCell(Text(p.amount.toString())),
                                        ]))
                                    .toList()),
                          ),
                          Container(
                            width: size.width,
                            height: 30,
                            color: green,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'Total Product: ${snapshot.data.data[index].products.length}',
                                    style: TextStyle(color: white),
                                  ),
                                  Text(
                                    'Total amount : ₹${amount(snapshot.data.data[index].products)} ',
                                    style: TextStyle(color: white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            height: 30,
                            color: amber,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                snapshot.data.data[index].pickupDate == null
                                    ? Text(
                                        'OTP : ${snapshot.data.data[index].deliveryCode}',
                                        style: TextStyle(color: white),
                                      )
                                    : Text(
                                        'Picked by  ${snapshot.data.data[index].employeeName} on ${snapshot.data.data[index].pickupDate}',
                                        style: TextStyle(color: white))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });

              break;
            default:
              return Text('Something Went Wrong');
          }
        },
      ),
    );
  }
}
