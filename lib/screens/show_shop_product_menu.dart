import 'package:flutter/material.dart';
import 'package:greenmarket/model/user_model.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:greenmarket/widget/about_shop.dart';
import 'package:greenmarket/widget/show_menu_product.dart';

class ShowShopProduct extends StatefulWidget {
  final UserModel userModel;
  ShowShopProduct({Key key, this.userModel}) : super(key: key);
  @override
  _ShowShopProductState createState() => _ShowShopProductState();
}

class _ShowShopProductState extends State<ShowShopProduct> {
  UserModel userModel;
  List<Widget> listWidgets = List();
  int indexPage = 0;

  @override
  
  void initState() {
    super.initState();
    userModel = widget.userModel;
    listWidgets.add(AboutShop(userModel: userModel,
    ));
    listWidgets.add(ShowMenuProduct(userModel: userModel,
    ));
  }

BottomNavigationBarItem aboutShopNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      title: Text('รายละเอียดร้านค้า'),
    );
  }
  BottomNavigationBarItem showMenuProductNav() {
    return BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu),
      title: Text('สินค้าเกษตร'),
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[Mystyle().iconShowCart(context)],
        title: Text(userModel.storename),
      ),
      body: listWidgets.length == 0
          ? Mystyle().showProgress()
          : listWidgets[indexPage],
      bottomNavigationBar: showBottonNavigationBar(),
    );
  }

BottomNavigationBar showBottonNavigationBar() => BottomNavigationBar(
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.white,
        currentIndex: indexPage,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        items: <BottomNavigationBarItem>[
          aboutShopNav(),
          showMenuProductNav(),
        ],
      );
      
}