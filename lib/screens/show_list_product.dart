import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greenmarket/model/cart_model.dart';
import 'package:greenmarket/model/product_model.dart';
import 'package:greenmarket/model/user_model.dart';
import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:greenmarket/utility/normal_dialog.dart';
import 'package:greenmarket/utility/sqlite_helper.dart';

class ShowListProduct extends StatefulWidget {
  final UserModel model;
  ShowListProduct({Key key, this.model}) : super(key: key);

  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  UserModel model;
  List<ProductModel> productModels = List();
  int amount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.model;
    readProduct();
  }

  Future<Null> readProduct() async {
    String idShop = model.id;
    print('isShop =>> $idShop');

    String path =
        '${MyConstant().domain}/GreenMarket1/getProductWhereIdShop.php?isAdd=true&idShop=$idShop';
    await Dio().get(path).then((value) {
      for (var json in json.decode(value.data)) {
        ProductModel model = ProductModel.fromJson(json);
        setState(() {
          productModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.storename),
      ),
      body: productModels.length == 0
          ? Mystyle().showProgress()
          : ListView.builder(
              itemCount: productModels.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => chooseOrder(productModels[index]),
                child: Card(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.5 - 10,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Text(
                                  productModels[index].nameProduct,
                                  style: Mystyle().mainTitle,
                                ),
                              ],
                            ),
                            Text('ราคา ${productModels[index].price} บาท'),
                            Text(contentDetail(productModels[index].detail)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: Image.network(
                            '${MyConstant().domain}${productModels[index].pathImage}'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  String contentDetail(String detail) {
    String string = detail;
    if (string.length > 100) {
      string = string.substring(0, 99);
      string = '$string ...';
    }
    return string;
  }

  Future<Null> chooseOrder(ProductModel productModel) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(productModel.nameProduct),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                  '${MyConstant().domain}${productModel.pathImage}'),
            ),
          ),
          Text(productModel.detail),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('จำนวน'),
              Container(
                margin: EdgeInsets.all(16),
                width: 100,
                child: TextFormField(
                  onChanged: (value) {
                    if (value.isEmpty) {
                      amount = 1;
                    } else {
                      amount = int.parse(value);
                    }
                  },
                  initialValue: amount.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ),
              Text('ชิ้น'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton.icon(
                onPressed: () async {
                  Navigator.pop(context);
                  print('amount ==>> $amount');

                  SQLiteHelper helper = SQLiteHelper();
                  CartModel cartModel = CartModel(
                      idShop: productModel.idShop,
                      storename: model.storename,
                      idProduct: productModel.id,
                      nameProduct: productModel.nameProduct,
                      price: productModel.price,
                      amount: amount.toString(),
                      sum: (int.parse(productModel.price) * amount).toString());
                  await helper.insertDataToSQLite(cartModel).then(
                        (value) =>
                            normalDialog(context, 'ใส่ตระกร้า เรียบร้อยแล้วคะ'),
                      );
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                label: Text('ใส่ตระกร้า'),
              ),
              FlatButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                label: Text('ยกเลิก'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
