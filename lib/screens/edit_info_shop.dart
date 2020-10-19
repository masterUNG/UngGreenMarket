import 'dart:io';
import 'dart:convert';
import 'dart:math';
//import 'dart:html';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greenmarket/model/user_model.dart';
import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:greenmarket/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class EditInfoShop extends StatefulWidget {
  @override
  _EditInfoShopState createState() => _EditInfoShopState();
}

class _EditInfoShopState extends State<EditInfoShop> {
  UserModel userModel;
  String name1, storename, address, phone, urlImage;

  File file;

  @override
  void initState() {
    super.initState();
    readCurrenInfo();
  }

  Future<Null> readCurrenInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    print('idShop ==>> $id');
    String url =
        '${MyConstant().domain}/GreenMarket1/getUserWhereId.php?isAdd=true&id=$id';

    Response response = await Dio().get(url);
    print('response ==>> $response');

    var result = json.decode(response.data);
    print('result ==>> $result');

    for (var map in result) {
      print('map ==>> $map');
      setState(() {
        userModel = UserModel.fromJson(map);
        name1 = userModel.name1;
        storename = userModel.storename;
        address = userModel.address;
        phone = userModel.phone;
        urlImage = userModel.urlImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userModel == null ? Mystyle().showProgress() : showContant(),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('ปรับปรุง รายละเอียดร้าน'),
      ),
    );
  }

  Widget showContant() => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            storenameForm(),
            addressForm(),
            phoneForm(),
            showImage(),
            editButton()
            //editButton(),
          ],
        ),
      );

  Widget editButton() => Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton.icon(
          color: Mystyle().primaryColor,
          onPressed: () => confirmDialog(),
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          label: Text(
            'ปรับปรุง รายละเอียด',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> confirmDialog() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณแน่ใจว่าจะ ปรับปรุงรายละเอียดร้าน นะคะ ?'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  Navigator.pop(context);
                  editThread();
                },
                child: Text('แน่ใจ'),
              ),
              OutlineButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ไม่แน่ใจ'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<Null> editThread() async {
    if (file == null) {
      editNewData();
    } else {
      Random random = Random();
      int i = random.nextInt(100000);
      String nameFile = 'editShop$i.jpg';

      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);

      String urlUpload = '${MyConstant().domain}/GreenMarket1/saveShop.php';
      await Dio().post(urlUpload, data: formData).then((value) async {
        urlImage = '/GreenMarket1/shop/$nameFile';

        await editNewData();
      });
    }
  }

  Future<Null> editNewData() async {
    String id = userModel.id;
    // print('id = $id');

    String url =
        '${MyConstant().domain}/GreenMarket1/editUserWhereId.php?isAdd=true&id=$id&name1=$storename&storename=$storename&address=$address&phone=$phone&phone=$phone&urlImage=$urlImage';
    Response response = await Dio().get(url);
    if (response.toString() == 'true') {
      Navigator.pop(context);
    } else {
      normalDialog(context, 'ยัง อัพเดทไม่ได้ กรุณาลองใหม่');
    }
  }

  Widget showImage() => Container(
        margin: EdgeInsetsDirectional.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () => chooseImage(ImageSource.camera),
            ),
            Container(
              width: 250.0,
              height: 250.0,
              child: file == null
                  ? Image.network('${MyConstant().domain}$urlImage')
                  : Image.file(file),
            ),
            IconButton(
              icon: Icon(Icons.add_photo_alternate),
              onPressed: () => chooseImage(ImageSource.gallery),
            ),
          ],
        ),
      );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker()
          .getImage(source: source, maxWidth: 800.0, maxHeight: 800.0);

      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Widget name1Form() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => name1 = value,
              initialValue: name1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ชื่อ-สกุล',
              ),
            ),
          ),
        ],
      );

  Widget storenameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => storename = value,
              initialValue: storename,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ชื่อร้านค้า',
              ),
            ),
          ),
        ],
      );
  Widget addressForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => address = value,
              initialValue: address,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ที่อยู่ร้านค้า',
              ),
            ),
          ),
        ],
      );
  Widget phoneForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => phone = value,
              initialValue: phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'เบอร์ติดต่อร้านค้า',
              ),
            ),
          ),
        ],
      );
}
