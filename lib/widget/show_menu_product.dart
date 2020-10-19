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
import 'package:toast/toast.dart';

class ShowMenuProduct extends StatefulWidget {
  final UserModel userModel;
  ShowMenuProduct({Key key, this.userModel}) : super(key: key);
  @override
  _ShowMenuProductState createState() => _ShowMenuProductState();
}

class _ShowMenuProductState extends State<ShowMenuProduct> { 
  UserModel userModel;
  String idShop;
  List<ProductModel> productModels = List();
  int amount = 1;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    readProductMenu();
  }

  Future<Null> readProductMenu() async {
    idShop = userModel.id;
    String url =
        '${MyConstant().domain}/GreenMarket1/getProductWhereIdShop.php?isAdd=true&idShop=$idShop';
    Response response = await Dio().get(url);
    // print('res --> $response');

    var result = json.decode(response.data);
    // print('result = $result');

    for (var map in result) {
      ProductModel productModel = ProductModel.fromJson(map);
      setState(() {
        productModels.add(productModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return productModels.length == 0
        ? Mystyle().showProgress()
        : ListView.builder(
            itemCount: productModels.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                // print('You Click index = $index');
                amount = 1;
                confirmOrder(index);
              },
              child: Row(
                children: <Widget>[
                  showProductImage(context, index),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              productModels[index].nameProduct,
                              style: Mystyle().mainTitle,
                            ),
                          ],
                        ),
                        Text(
                          '${productModels[index].price} บาท',
                          style: TextStyle(
                            fontSize: 40,
                            color: Mystyle().darkColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.5 - 8.0,
                              child: Text(productModels[index].detail),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Container showProductImage(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      width: MediaQuery.of(context).size.width * 0.5 - 16.0,
      height: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(
              '${MyConstant().domain}${productModels[index].pathImage}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<Null> confirmOrder(int index) async {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                productModels[index].nameProduct,
                style: Mystyle().mainH2Title,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 180,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: NetworkImage(
                          '${MyConstant().domain}${productModels[index].pathImage}'),
                      fit: BoxFit.cover),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      size: 36,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        amount++;
                        // print('amount = $amount');
                      });
                    },
                  ),
                  Text(
                    amount.toString(),
                    style: Mystyle().mainTitle,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.remove_circle,
                      size: 36,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      if (amount > 1) {
                        setState(() {
                          amount--;
                        });
                      }
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 110,
                    child: RaisedButton(
                      color: Mystyle().primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () {
                        Navigator.pop(context);
                        // print(
                        //     'Order ${foodModels[index].nameFood} Amount = $amount');

                        //addOrderToCart(index);
                      },
                      child: Text(
                        'Order',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    width: 110,
                    child: RaisedButton(
                      color: Mystyle().primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> addOrderToCart(int index) async {
    String storename = userModel.storename;
    String idProduct = productModels[index].id;
    String nameProduct = productModels[index].nameProduct;
    String price = productModels[index].price;

    int priceInt = int.parse(price);
    int sumInt = priceInt * amount;

    print(
        'idShop = $idShop, storename = $storename, idProduct = $idProduct, nameProduct = $nameProduct, price = $price, amount = $amount, sum = $sumInt');

    Map<String, dynamic> map = Map();

    map['idShop'] = idShop;
    map['storename'] = storename;
    map['idProduct'] = idProduct;
    map['nameProduct'] = nameProduct;
    map['price'] = price;
    map['amount'] = amount.toString();
    map['sum'] = sumInt.toString();

    print('map ==> ${map.toString()}');

    CartModel cartModel = CartModel.fromJson(map);

    var object = await SQLiteHelper().readAllDataFromSQLite();
    print('object lenght = ${object.length}');

    if (object.length == 0) {
      await SQLiteHelper().insertDataToSQLite(cartModel).then((value) {
        print('Insert Success');
        showToast('Insert Success');
      });
    } else {
      String idShopSQLite = object[0].idShop;
      print('idShopSQLite ==> $idShopSQLite');
      if (idShop == idShopSQLite) {
        await SQLiteHelper().insertDataToSQLite(cartModel).then((value) {
          print('Insert Success');
          showToast('Insert Success');
        });
      } else {
        normalDialog(context,
            'ตะกร้ามี รายการสินค้าของ ร้าน ${object[0]..storename} กรุณา ซื้อจากร้านนี่ให้ จบก่อน คะ');
      }
    }
  }

  void showToast(String string) {
    Toast.show(
      string,
      context,
      duration: Toast.LENGTH_LONG,
    );
  }
}