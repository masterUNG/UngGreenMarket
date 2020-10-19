import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greenmarket/model/user_model.dart';
import 'package:greenmarket/screens/add_info_shop.dart';
import 'package:greenmarket/screens/edit_info_shop.dart';
import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationShop extends StatefulWidget {
  @override
  _InformationShopState createState() => _InformationShopState();
}

class _InformationShopState extends State<InformationShop> {
  UserModel userModel;
  bool statusLoad = true; // true ==> Continue Load Data

  @override
  void initState() {
    super.initState();
    readDataUser();
  }

  Future<Null> readDataUser() async {
    if (userModel != null) {
      userModel = null;
      statusLoad = true;
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');

    String url =
        '${MyConstant().domain}/GreenMarket1/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(url).then((value) {
      // print('value #######=>>>>>> $value');
      var result = json.decode(value.data);
      // print('result = $result');
      for (var map in result) {
        setState(() {
          print('Work#########');
          userModel = UserModel.fromJson(map);
          statusLoad = false;
        });
        print('storename = ${userModel.storename}');
      }
    });
  }

  void routeToAddInfo() {
    // print('routeToAddInfo Work');
    Widget widget =
        userModel.storename.isEmpty ? Addinfoshop() : EditInfoShop();
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.push(context, materialPageRoute).then((value) => readDataUser());
  }

  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   children: <Widget>[
    //     userModel != null
    //         ? Mystyle().showProgress()
    //         : userModel.storename.isEmpty
    //             ? showNoData(context)
    //             : showListInfoShop(),
    //     addAnEditButton(),
    //   ],
    // );

    return statusLoad
        ? Mystyle().showProgress()
        : userModel.storename.length != 0
            ? showListInfoShop()
            : showNoData(context);
  }

  Widget showListInfoShop() => Column(
        children: <Widget>[
          Mystyle().showTitleH2('รายละเอียดร้าน ${userModel.storename}'),
          showImage(),
          Row(
            children: <Widget>[
              Mystyle().showTitleH2('ที่อยู่ของร้าน'),
            ],
          ),
          Row(
            children: <Widget>[
              Text(userModel.address),
            ],
          ),
          RaisedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditInfoShop(),
              ),
            ).then((value) => readDataUser()),
            child: Text('Edit ข้อมูล ร้านค้า'),
          ),
        ],
      );

  Container showImage() {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Image.network('${MyConstant().domain}${userModel.urlImage}'),
    );
  }

  Widget showNoData(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Mystyle()
              .titleCenter(context, 'ยังไม่มี ข้อมูล กรุณาเพิ่มข้อมูลด้วย คะ'),
          RaisedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Addinfoshop(),
              ),
            ).then((value) => readDataUser()),
            child: Text('เพิ่มข้อมูลร้าน'),
          ),
        ],
      ),
    );
  }

  Row addAnEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                right: 16.0,
                bottom: 16.0,
              ),
              child: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () {
                  print('you click floating');
                  routeToAddInfo();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
