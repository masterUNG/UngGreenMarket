import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greenmarket/utility/my_constant.dart';
//import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:greenmarket/utility/normal_dialog.dart';

class SingUp extends StatefulWidget {
  @override
  _SingupState createState() => _SingupState();
}

class _SingupState extends State<SingUp> {
  String chooseType,
      name,
      surname,
      username,
      password,
      houseno,
      villageNo,
      subdistrict,
      district,
      province,
      postalcode,
      tel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('สมัครสมาชิก',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            )),
      ),
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
                myLogo(),
                Mystyle().mySizebox(),
                ShowAppName(),
                Mystyle().mySizebox(),
                nameForm(),
                Mystyle().mySizebox(),
                surnameForm(),
                Mystyle().mySizebox(),
                userForm(),
                Mystyle().mySizebox(),
                passwordForm(),
                Mystyle().mySizebox(),
                Mystyle().mySizebox(),
                Mystyle().showTitleH2('ช่องทางการติดต่อ :'),
                Mystyle().mySizebox(),
                housenoForm(),
                Mystyle().mySizebox(),
                villageNoForm(),
                Mystyle().mySizebox(),
                subdistrictForm(),
                Mystyle().mySizebox(),
                districtForm(),
                Mystyle().mySizebox(),
                provinceForm(),
                Mystyle().mySizebox(),
                postalcodeForm(),
                Mystyle().mySizebox(),
                telForm(),
                Mystyle().mySizebox(),
                Mystyle().mySizebox(),
                Mystyle().showTitleH2('ชนิดของสมาชิก :'),
                Mystyle().mySizebox(),
                userRadio(),
                buyRadio(),
                Mystyle().mySizebox(),
                registerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registerButton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: Mystyle().darkColor,
          onPressed: () {
            print(
                'name = $name, surname = $surname, username = $username, password = $password, houseno = $houseno, villageNo = $villageNo, subdistrict = $subdistrict, district = $district, province = $province, postalcode =$postalcode, tel = $tel, chooseType = $chooseType');
            if (name == null ||
                name.isEmpty ||
                surname == null ||
                surname.isEmpty ||
                username == null ||
                username.isEmpty ||
                password == null ||
                password.isEmpty ||
                houseno == null ||
                houseno.isEmpty ||
                villageNo == null ||
                villageNo.isEmpty ||
                subdistrict == null ||
                subdistrict.isEmpty ||
                district == null ||
                district.isEmpty ||
                district == null ||
                province.isEmpty ||
                postalcode == null ||
                postalcode.isEmpty ||
                tel == null ||
                tel.isEmpty) {
              print('Have Space');
              normalDialog(context, 'มีช่องว่าง กรุณากรอกทุกช่องค่ะ');
            } else if (chooseType == null) {
              normalDialog(context, 'โปรดเลือกประเภทผู้สมัคร');
            } else {
              checkUser();
            }
          },
          child: Text(
            'สมัครสมาชิก',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> checkUser() async {
    String url =
        '${MyConstant().domain}/GreenMarket1/getUserWhereUser.php?isAdd=true&username=$username';
    print('url ===>>> $url');
    try {
      Response response = await Dio().get(url);
      print('res ######==>>> $response');
      if (response.toString() == 'null') {
        registerThread();
      } else {
        normalDialog(
            context, 'user นี้ $username มี คนอื่นใช้แล้ว เปลี่ยนใหม่');
      }
    } catch (e) {}
  }

  Future<Null> registerThread() async {
    String url =
        '${MyConstant().domain}/GreenMarket1/addUser.php?isAdd=true&name=$name&surname=$surname&username=$username&password=$password&houseno=$houseno&villageNo=$villageNo&subdistrict=$subdistrict&district=$district&province=$province&postalcode=$postalcode&tel=$tel&chooseType=$chooseType';

    try {
      Response response = await Dio().get(url);
      print('res = $response');
      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'ไม่สามารถสมัครได้ กรุณาลองใหม่คะ');
      }
    } catch (e) {
      print(e);
    }
  }

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Mystyle().darkColor,
                ),
                labelStyle: TextStyle(color: Mystyle().darkColor),
                labelText: 'ชื่อ :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget surnameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => surname = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person,
                  color: Mystyle().darkColor,
                ),
                labelStyle: TextStyle(color: Mystyle().darkColor),
                labelText: 'นามสกุล :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
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
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => password = value.trim(),
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
          ),
        ],
      );

  Widget housenoForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => houseno = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.home,
                  color: Mystyle().darkColor,
                ),
                labelStyle: TextStyle(color: Mystyle().darkColor),
                labelText: 'บ้านเลขที่ :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget villageNoForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => villageNo = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.home,
                  color: Mystyle().darkColor,
                ),
                labelStyle: TextStyle(color: Mystyle().darkColor),
                labelText: 'หมู่ที่ :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget subdistrictForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => subdistrict = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.home,
                  color: Mystyle().darkColor,
                ),
                labelStyle: TextStyle(color: Mystyle().darkColor),
                labelText: ' ตำบล :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget districtForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => district = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.home,
                  color: Mystyle().darkColor,
                ),
                labelStyle: TextStyle(color: Mystyle().darkColor),
                labelText: 'อำเภอ :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget provinceForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => province = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.home,
                  color: Mystyle().darkColor,
                ),
                labelStyle: TextStyle(color: Mystyle().darkColor),
                labelText: 'จังหวัด :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget postalcodeForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => postalcode = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.home,
                  color: Mystyle().darkColor,
                ),
                labelStyle: TextStyle(color: Mystyle().darkColor),
                labelText: 'รหัสไปรษณีย์ :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget telForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => tel = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.call,
                  color: Mystyle().darkColor,
                ),
                labelStyle: TextStyle(color: Mystyle().darkColor),
                labelText: 'เบอร์โทรศัพท์ :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Mystyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget userRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                  value: 'dealer',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  'ผู้จำหน่าย',
                  style: TextStyle(color: Mystyle().darkColor),
                )
              ],
            ),
          ),
        ],
      );

  Widget buyRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 250.0,
            child: Row(
              children: <Widget>[
                Radio(
                  value: 'buyer',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value;
                    });
                  },
                ),
                Text(
                  'ผู้ซื้อ',
                  style: TextStyle(color: Mystyle().darkColor),
                )
              ],
            ),
          ),
        ],
      );

  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Mystyle().showLogo(),
        ],
      );
}

class ShowAppName extends StatelessWidget {
  const ShowAppName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Mystyle().showTitle(' Prakha Green Market '),
      ],
    );
  }
}
