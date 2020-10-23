import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greenmarket/model/order_model.dart';
import 'package:greenmarket/model/user_model.dart';
import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListShop extends StatefulWidget {
  @override
  _OrderListShopState createState() => _OrderListShopState();
}

class _OrderListShopState extends State<OrderListShop> {
  UserModel userModel;
  List<OrderModel> orderModels = List();
  List<List<String>> listNameProducts = List();
  List<List<String>> listPrices = List();
  List<List<String>> listAmounts = List();
  List<List<String>> listSums = List();
  List<int> totals = List();

  @override
  void initState() {
    super.initState();
    readOrder();
  }

  Future<Null> readOrder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idShop = preferences.getString('id');

    String path =
        '${MyConstant().domain}/GreenMarket1/getOrderWhereIdShop.php?isAdd=true&idShop=$idShop';
    await Dio().get(path).then((value) {
      // print('value ==> $value');
      if (value.toString() != 'null') {
        for (var json in json.decode(value.data)) {
          // print('json ==>> $json');
          OrderModel model = OrderModel.fromJson(json);
          // print('nameUser ==> ${model.nameUser}');

          List<String> nameProducts = changeArray(model.nameProduct);
          List<String> prices = changeArray(model.price);
          List<String> amounts = changeArray(model.amount);
          List<String> sums = changeArray(model.sum);

          int total = 0;
          for (var sum in sums) {
            total = total + int.parse(sum.trim());
          }

          setState(() {
            orderModels.add(model);
            listNameProducts.add(nameProducts);
            listAmounts.add(amounts);
            listPrices.add(prices);
            listSums.add(sums);
            totals.add(total);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return orderModels.length == 0
        ? Center(child: Text('ยังไม่มี Order'))
        : ListView.builder(
            itemCount: orderModels.length,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date Order ==> ${orderModels[index].orderDateTime}'),
                buildHeadTitle(),
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listNameProducts[index].length,
                  itemBuilder: (context, index2) => Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(listNameProducts[index][index2]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(listPrices[index][index2]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(listAmounts[index][index2]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(listSums[index][index2]),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Total :  '),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        totals[index].toString(),
                        style: Mystyle().mainH2Title,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }

  Container buildHeadTitle() {
    return Container(
      decoration: BoxDecoration(color: Mystyle().darkColor),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'Name Product',
                style: Mystyle().mainH2TitleWhite,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Price',
                style: Mystyle().mainH2TitleWhite,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Amount',
                style: Mystyle().mainH2TitleWhite,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                'Sum',
                style: Mystyle().mainH2TitleWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> changeArray(String string) {
    String result = string.substring(1, string.length - 1);
    // print('result ==> $result');
    List<String> list = result.split(',');
    int index = 0;
    for (var string in list) {
      list[index] = string.trim();
      index++;
    }
    // print('list ==> $list');
    return list;
  }
}
