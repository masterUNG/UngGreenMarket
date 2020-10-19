import 'package:flutter/material.dart';
import 'package:greenmarket/screens/show_cart.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:greenmarket/widget/show_list_shop_all.dart';
import 'package:greenmarket/widget/show_status_product_order.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:greenmarket/utility/signout_process.dart';



class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String username;
  Widget currentWidget;
  //List<UserModel> userModels = List();
  
  @override
  void initState() {
    super.initState();
    currentWidget = ShowListShopAll();
    findUser(); 
     //readShop();
  }

    
/*Future<Null> readShop() async {
    String url =
        '${MyConstant().domain}/GreenMarket1/getUserWhereChooseType.php?isAdd=true&chooseType=buyer';
    await Dio().get(url).then((value) {
      var result = json.decode(value.data);
       
     for (var map in result){
       UserModel model = UserModel.fromJson(map);

       String nameShop =model.nameShop;
       if(nameShop.isNotEmpty){
      print('nameShop = ${model.storename}');
      setState(() {

         userModels.add(model);
       });
}  
     }

    });
  }*/


Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('name');
    });
  }

  /*void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }*/


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  backgroundColor: Colors.greenAccent,
        title: Text(username == null ? 'Main User' : '$username login'),
        actions: <Widget>[
          //MyStyle().iconShowCart(context),
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
                showHead(),
                productListShop(),
                productCart(),
                productStatusproductOrder(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                productSignOut(),
              ],
            ),
          ],
        ),
      );
//สินค้า

        ListTile productListShop() {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        setState(() {
         currentWidget = ShowListShopAll();
        });
      },
      leading: Icon(Icons.home),
      title: Text('แสดงร้านค้า'),
      subtitle: Text('แสดงร้านค้า ที่สามารถสั่งสินค้าได้'),
    );
  }
  
//รายการที่ลูกค้าสั่งซื้อ
 ListTile productStatusproductOrder() {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentWidget = ShowStatusProductOrder();
        });
      },
      leading: Icon(Icons.restaurant_menu),
      title: Text('แสดงรายการสินค้าที่สั่ง'),
      subtitle: Text('แสดงรายการสินค้าที่สั่ง และ หรือ ดูสถานะของสินค้าที่สั่ง'),
    );
  }


  /*ListTile  order() {
    return ListTile(
        leading: Icon(Icons.shopping_cart),
        title: Text('รายการสั่งซื้อ'),
         onTap: () {
            setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );
  }*/


  Widget productSignOut() {
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


    UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/user.png'), fit: BoxFit.cover),
        ),
        currentAccountPicture: Mystyle().showLogo3(),
        accountName: Text(
          'Green Market',
          style: TextStyle(fontSize: 30.0,color: Colors.black,
          ),
        ),
        accountEmail: Text
        ('ผู้ซื้อ',
            style: TextStyle(fontSize: 20.0,color: Colors.black,
            ),
          ),
        );
    }

  Widget productCart() { 
    return ListTile(
      leading: Icon(Icons.add_shopping_cart),
      title: Text('ตะกร้า ของฉัน'),
      subtitle: Text('รายการสินค้าที่อยู่ใน ตะกร้า ยังไม่ได้ Order'),
      onTap: () {
        Navigator.pop(context);
        // ignore: missing_required_param
        MaterialPageRoute route = MaterialPageRoute (
         builder: (context) => ShowCart(),
        );
        Navigator.push(context, route);
      },
    );
  }
}
