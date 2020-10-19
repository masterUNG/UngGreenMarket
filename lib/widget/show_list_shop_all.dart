import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greenmarket/model/user_model.dart';
import 'package:greenmarket/screens/show_list_product.dart';
import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/my_styte.dart';

class ShowListShopAll extends StatefulWidget {
  @override
  _ShowListShopAllState createState() => _ShowListShopAllState();
}

class _ShowListShopAllState extends State<ShowListShopAll> {
  List<UserModel> userModels = List();
  List<Widget> shopCards = List();

  @override
  void initState() {
    super.initState();
    readShop();
  }

  Future<Null> readShop() async {
    print('readShop Work');
    String url =
        '${MyConstant().domain}/GreenMarket1/getUserWhereChooseType.php?isAdd=true&chooseType=dealer';
    print('##########url ==>> $url');
    await Dio().get(url).then((value) {
      print('value =########## $value');
      var result = json.decode(value.data);
      int index = 0;
      for (var map in result) {
        UserModel model = UserModel.fromJson(map);

        String nameShop = model.storename;
        if (nameShop.isNotEmpty) {
          print('NameShop = ${model.storename}');
          setState(() {
            userModels.add(model);
            shopCards.add(createCard(model, index));
            index++;
          });
        }
      }
    });
  }

  Widget createCard(UserModel userModel, int index) {
    return GestureDetector(
      onTap: () {
        print('You Click index $index');
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowListProduct(model: userModels[index],),));
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 80.0,
              height: 80.0,
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage('${MyConstant().domain}${userModel.urlImage}'),
              ),
            ),
            Mystyle().mySizebox(),
            Container(
              width: 120,
              child: Mystyle().showTitleH3(userModel.storename),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return shopCards.length == 0
        ? Mystyle().showProgress()
        : GridView.extent(
            maxCrossAxisExtent: 220,
            children: shopCards,
          );
  }
}
