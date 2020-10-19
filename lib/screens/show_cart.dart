import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greenmarket/model/cart_model.dart';
import 'package:greenmarket/model/user_model.dart';
import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:greenmarket/utility/normal_dialog.dart';
import 'package:greenmarket/utility/sqlite_helper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ShowCart extends StatefulWidget {
  @override
  _ShowCartState createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<CartModel> cartModels = List();
  int total = 0;
  bool status = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSQLite();
  }

  Future<Null> readSQLite() async {
    print('readSQLite Work');
    var object = await SQLiteHelper().readAllDataFromSQLite();
    print('object length ==> ${object.length}');
    if (object.length != 0) {
      for (var model in object) {
        String sumString = model.sum;
        int sumInt = int.parse(sumString);
        setState(() {
          status = false;
          cartModels = object;
          total = total + sumInt;
        });
      }
    } else {
      setState(() {
        status = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตะกร้าของฉัน'),
      ),
      body: status
          ? Center(
              child: Text('ตะกร้าว่างเปล่า'),
            )
          : buildContent(),
    );
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildNameShop(),
            buildHeadTitle(),
            buildListProduct(),
            Divider(),
            buildTotal(),
            buildClearCartButton(),
            buildOrderButton(),
          ],
        ),
      ),
    );
  }

  Widget buildClearCartButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 150,
          child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Mystyle().primaryColor,
              onPressed: () {
                confirmDeleteAllData();
              },
              icon: Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
              label: Text(
                'Clear ตะกร้า',
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }

  Widget buildOrderButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 150,
          child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Mystyle().darkColor,
              onPressed: () {
                orderThread();
              },
              icon: Icon(
                Icons.fastfood,
                color: Colors.white,
              ),
              label: Text(
                'Order',
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }

  Widget buildTotal() => Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Mystyle().showTitleH2('Total : '),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Mystyle().showTitleH3Red(total.toString()),
          )
        ],
      );

  Widget buildNameShop() {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Mystyle().showTitleH2('ร้าน ${cartModels[0].storename}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeadTitle() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Mystyle().showTitleH3('รายการสินค้า'),
          ),
          Expanded(
            flex: 1,
            child: Mystyle().showTitleH3('ราคา'),
          ),
          Expanded(
            flex: 1,
            child: Mystyle().showTitleH3('จำนวน'),
          ),
          Expanded(
            flex: 1,
            child: Mystyle().showTitleH3('ผลรวม'),
          ),
          Expanded(
            flex: 1,
            child: Mystyle().mySizebox(),
          )
        ],
      ),
    );
  }

  Widget buildListProduct() => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: cartModels.length,
        itemBuilder: (context, index) => Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Text(cartModels[index].nameProduct),
            ),
            Expanded(
              flex: 1,
              child: Text(cartModels[index].price),
            ),
            Expanded(
              flex: 1,
              child: Text(cartModels[index].amount),
            ),
            Expanded(
              flex: 1,
              child: Text(cartModels[index].sum),
            ),
            Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () async {
                    int id = cartModels[index].id;
                    print('You Click Delete id = $id');
                    await SQLiteHelper().deleteDataWhereId(id).then((value) {
                      print('Success Delete id = $id');
                      readSQLite();
                    });
                  },
                )),
          ],
        ),
      );

  Future<Null> confirmDeleteAllData() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการจะลบ รายการอาหารทั้งหมด จริงๆ หรือ ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Mystyle().primaryColor,
                onPressed: () async {
                  Navigator.pop(context);
                  await SQLiteHelper().deleteAllData().then((value) {
                    readSQLite();
                  });
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                label: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Mystyle().primaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                label: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<Null> orderThread() async {
    DateTime dateTime = DateTime.now();
    // print(dateTime.toString());
    String orderDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

    String idShop = cartModels[0].idShop;
    String nameShop = cartModels[0].storename;

    List<String> idProduct = List();
    List<String> nameProduct = List();
    List<String> prices = List();
    List<String> amounts = List();
    List<String> sums = List();

    for (var model in cartModels) {
      idProduct.add(model.idProduct);
      print('#################### idProduct ==>>> $idProduct');
      nameProduct.add(model.nameProduct);
      prices.add(model.price);
      amounts.add(model.amount);
      sums.add(model.sum);
    }

    String price = prices.toString();
    String amount = amounts.toString();
    String sum = sums.toString();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idUser = preferences.getString('id');
    String nameUser = preferences.getString('name');

    print(
        'orderDateTime = $orderDateTime, idUser = $idUser, nameUser = $nameUser, idShop = $idShop, nameShop = $nameShop');
    print(
        'idProduct = $idProduct, nameProduct = $nameProduct, price = $price, amount = $amount, sum = $sum');

    String url = '${MyConstant().domain}/GreenMarket1/addOrder.php?isAdd=true&OrderDateTime=$idShop&idUser=$idUser&NameUser=$nameUser&idShop=$idShop&NameShop=$nameShop&idProduct=$idProduct&NameProduct=$nameProduct&Price=$price&Amount=$amount&Sum=$sum';

    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        clearAllSQLite();
        notificationToShop(idShop);
      } else {
        normalDialog(context, 'ไม่สามารถ Order ได้ กรุณาลองใหม่');
      }
    });
  }

  Future<Null> clearAllSQLite() async {
    Toast.show(
      'Order เรียบร้อยแล้ว คะ',
      context,
      duration: Toast.LENGTH_LONG,
    );
    await SQLiteHelper().deleteAllData().then((value) {
      readSQLite();
    });
  }

  Future<Null> notificationToShop(String idShop) async {
    String urlFindToken =
        '${MyConstant().domain}/GreenMarket1/getUserWhereId.php?isAdd=true&id=$idShop';
    await Dio().get(urlFindToken).then((value) {
      var result = json.decode(value.data);
      print('result ==> $result');
      for (var json in result) {
        UserModel model = UserModel.fromJson(json);
        String tokenShop = model.token;
        print('tokenShop ==>> $tokenShop');

        String title = 'มี Order จากลูกค้า';
        String body = 'มีการสั่งอาหาร จากลูกค้า ครับ';
        String urlSendToken =
            '${MyConstant().domain}/GreenMarket1/apiNotification.php?isAdd=true&token=$tokenShop&title=$title&body=$body';

        sendNotificationToShop(urlSendToken);
      }
    });
  }

  Future<Null> sendNotificationToShop(String urlSendToken) async {
    await Dio().get(urlSendToken).then(
          (value) => normalDialog(context, 'ส่ง Order ไปที่ ร้านค้าแล้ว คะ'),
        );
  }
}
