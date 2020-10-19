import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greenmarket/model/user_model.dart';
import 'package:greenmarket/screens/main_admin.dart';
import 'package:greenmarket/screens/main_shop.dart';
import 'package:greenmarket/screens/main_user.dart';
import 'package:greenmarket/screens/singup.dart';
import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:greenmarket/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //String get data => null;
  String username, password;
  bool statusLogin = true; // true => Non Login

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStatusLogin();
  }

  Future<Null> checkStatusLogin() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String type = preferences.getString('chooseType');
      if (type != null) {
        username = preferences.getString('username');
        password = preferences.getString('password');
        statusLogin = false;
        checkAuthen();
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.greenAccent,
      //   title: Text('เข้าสู่ระบบ',
      //       style: TextStyle(
      //         fontSize: 20.0,
      //         color: Colors.black,
      //       )),
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, Mystyle().primaryColor],
            center: Alignment(0, -0.3),
            radius: 1.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Mystyle().showLogo(),
                Mystyle().mySizebox(),
                Mystyle().showTitle('Prakha Green Market'),
                // Mystyle().showTitleH3Purple('ตำบลแพรกหา อำเภอควนขนุน จังหวัดพัทลุง'),
                Mystyle().mySizebox(),
                usernameForm(),
                Mystyle().mySizebox(),
                //ปุ่มล็อคอิน
                passwordForm(),
                Mystyle().mySizebox(),
                loginButton(),
                buildFlatButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  FlatButton buildFlatButton() {
    return FlatButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SingUp(),
        ),
      ),
      child: Text(
        'สมัคร สมาชิกใหม่',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Widget loginButton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: Mystyle().darkColor,
          onPressed: () {
/*Navigator.push(context,
MaterialPageRoute(builder: (context) => MainShop()));*/

            if (username == null ||
                username.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'มีช่องว่าง กรุณากรอกให้ครบคะ');
            } else {
              checkAuthen();
            }
          },
          child: Text(
            'เข้าสู่ระบบ',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> checkAuthen() async {
    String url =
        '${MyConstant().domain}/GreenMarket1/getUserWhereUser.php?isAdd=true&username=$username';
    print('url ===>> $url');
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('result =$result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
          String chooseType = userModel.chooseType;
          checkTypeAndRoute(chooseType, userModel);
        } else {
          normalDialog(context, 'password ผิดกรุณาลองใหม่');
        }
      }
    } catch (e) {}
  }

  void checkTypeAndRoute(String chooseType, UserModel userModel) {
    if (chooseType == 'dealer') {
      routeTuService(MainShop(), userModel);
    } else if (chooseType == 'buyer') {
      routeTuService(MainUser(), userModel);
    } else if (chooseType == 'admin') {
      routeTuService(MainAdmin(), userModel);
    } else {
      normalDialog(context, 'Error');
    }
  }

  Future<Null> routeTuService(Widget myWidget, UserModel userModel) async {
    if (statusLogin) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('chooseType', userModel.chooseType);
    preferences.setString('name', userModel.name);
    preferences.setString('username', userModel.username);
    preferences.setString('password', userModel.password);
    }

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  //กรอบเข้าสู่ระบบ
  Widget usernameForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => username = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: Mystyle().darkColor,
            ),
            labelStyle: TextStyle(color: Mystyle().darkColor),
            labelText: 'ชื่อผู้ใช้ :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mystyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mystyle().primaryColor)),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: Mystyle().darkColor,
            ),
            labelStyle: TextStyle(color: Mystyle().darkColor),
            labelText: 'รหัสผ่าน :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mystyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Mystyle().primaryColor)),
          ),
        ),
      );
}
