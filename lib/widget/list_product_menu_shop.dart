import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:greenmarket/model/product_model.dart';
import 'package:greenmarket/screens/add_product_menu.dart';
import 'package:greenmarket/screens/edit_product_menu.dart';
import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class ListProductMenuShop extends StatefulWidget {
  @override
  _ListProductMenuShopState createState() => _ListProductMenuShopState();
}

class _ListProductMenuShopState extends State<ListProductMenuShop> {
  bool loadStatus = true; // Process Load JSON
  bool status = true; // Have Data
  List<ProductModel> productModels = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readProductMenu();
  }

  Future<Null> readProductMenu() async {
    if (productModels.length != 0) {
      loadStatus = true;
      status = true;
      productModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idShop = preferences.getString('id');
    print('idShop = $idShop');

    String url =
        '${MyConstant().domain}/GreenMarket1/getProductWhereIdShop.php?isAdd=true&idShop=$idShop';
    await Dio().get(url).then((value) {
      // print('value #######==>> $value');

      setState(() {
        loadStatus = false;
      });

      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        print('result #######==>> $result');

        for (var map in result) {
          ProductModel productModel = ProductModel.fromJson(map);
          setState(() {
            productModels.add(productModel);
          });
        }
      } else {
        setState(() {
          status = false; // ไม่มีสินค้าแสดง
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return loadStatus
        ? Mystyle().showProgress()
        : status
            ? showListProduct()
            : buildNoProduct(context);
  }

  Center buildNoProduct(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Mystyle().showTitle('ยังไม่มีสินค้าแสดง'),
          RaisedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddProductMenu(),
              ),
            ).then((value) => readProductMenu()),
            child: Text('เพิ่มสินค้า'),
          )
        ],
      ),
    );
  }

  Widget showContent() {
    return status
        ? showListProduct()
        : Center(
            child: Text('ยังไม่มีรายการอาหาร'),
          );
  }

  Widget showListProduct() => Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: productModels.length,
            itemBuilder: (context, index) => Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: Image.network(
                    '${MyConstant().domain}${productModels[index].pathImage}',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          productModels[index].nameProduct,
                          style: Mystyle().mainTitle,
                        ),
                        Text(
                          'ราคา ${productModels[index].price} บาท',
                          style: Mystyle().mainH2Title,
                        ),
                        Text(productModels[index].detail),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => EditProductMenu(
                                    productModel: productModels[index],
                                  ),
                                );
                                Navigator.push(context, route)
                                    .then((value) => readProductMenu());
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  deleateProduct(productModels[index]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProductMenu(),
                        ),
                      ).then((value) => readProductMenu(),),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      );

  Future<Null> deleateProduct(ProductModel productModel) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Mystyle()
            .showTitleH2('คุณต้องการลบ เมนู ${productModel.nameProduct} ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.pop(context);
                  String url =
                      '${MyConstant().domain}/GreenMarket1/deleateProductWhereId.php?isAdd=true&id=${productModel.id}';
                  await Dio().get(url).then((value) => readProductMenu());
                },
                child: Text('ยืนยัน'),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ยังไม่ลบ'),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget addMenuButton() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => AddProductMenu(),
                    );
                    Navigator.push(context, route)
                        .then((value) => readProductMenu());
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      );
}
