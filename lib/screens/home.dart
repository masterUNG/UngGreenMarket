import 'package:flutter/material.dart';
import 'package:greenmarket/screens/main_shop.dart';
import 'package:greenmarket/screens/main_user.dart';
import 'package:greenmarket/screens/singIn.dart';
import 'package:greenmarket/screens/singup.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:greenmarket/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    checkPreferance();
  }

  Future<Null> checkPreferance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String choosType = preferences.getString('chooseType');
      if (choosType != null && choosType.isNotEmpty) {
        if (choosType == 'dealer') {
          routeToService(MainShop());
        } else if (choosType == 'buyer') {
          routeToService(MainUser());
        }else{
          normalDialog(context, 'Error');
        }
      }
    } catch (e) {}
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
      ),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHeadDrawer(),
            signInMenu(),
            signUpMenu(),
          ],
        ),
      );

  ListTile signInMenu() {
    return ListTile(
      leading: Icon(Icons.input),
      title: Text('เข้าสู่ระบบ'),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);
      },
    );
  }

  ListTile signUpMenu() {
    return ListTile(
        leading: Icon(Icons.person_add),
        title: Text('สมัครสมาชิก'),
        onTap: () {
          Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => SingUp());
          Navigator.push(context, route);
        });
  }

  UserAccountsDrawerHeader showHeadDrawer() {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/veget.jpg'), fit: BoxFit.cover),
        ),
        currentAccountPicture: Mystyle().showLogo(),
        accountName: Text(
          'Green Market',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
          ),
        ),
        accountEmail: Text('ตำบลแพรกหา อำเภอควนขนุน จังหวัดพัทลุง',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            )));
  }
}
