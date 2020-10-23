import 'package:flutter/material.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:greenmarket/utility/signout_process.dart';
import 'package:greenmarket/widget/information_shop.dart';
import 'package:greenmarket/widget/list_product_menu_shop.dart';
import 'package:greenmarket/widget/order_list_shop.dart';


class MainShop extends StatefulWidget {
  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  Widget currentWidget = OrderListShop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('Main Shop'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOutProcess(context),
          )
        ],
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showHeadDrawer(),
                product(),
                order(),
                storename(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                signOutMenu(),
              ],
            ),
          ],
        ),
      );

  //สินค้า

  ListTile product() => ListTile(
        leading: Icon(Icons.library_add),
        title: Text('สินค้าเกษตร'),
        subtitle: Text('รายการสินค้าเกษตรของร้าน'),
        onTap: () {
          setState(() {
            currentWidget = ListProductMenuShop();
          });
          Navigator.pop(context);
        },
      );

//รายการที่ลูกค้าสั่งซื้อ
  ListTile order() => ListTile(
        leading: Icon(Icons.local_grocery_store),
        title: Text('รายการที่ลูกค้าสั่งซื้อ'),
        subtitle: Text('รายการสินค้าเกษตรที่ยังไม่ได้ ส่งให้ลูกค้า'),
        onTap: () {
          setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile storename() => ListTile(
        leading: Icon(Icons.store),
        title: Text('รายละเอียดร้านค้า'),
        subtitle: Text('รายละเอียดของร้าน พร้อม Edit'),
        onTap: () {
          setState(() {
            currentWidget = InformationShop();
          });
          Navigator.pop(context);
        },
      );

  Widget signOutMenu() {
    return Container(
      decoration: BoxDecoration(color: Colors.greenAccent),
      child: ListTile(
        onTap: () => signOutProcess(context),
        leading: Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
        title: Text(
          'Sign Out',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'การออกจากแอพ',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/k.png'), fit: BoxFit.cover),
      ),
      currentAccountPicture: Mystyle().showLogo1(),
      accountName: Text(
        'Green Market',
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
      accountEmail: Text('ผู้จำหน่าย',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          )),
    );
  }
}
