import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:greenmarket/utility/normal_dialog.dart';

class Addinfoshop extends StatefulWidget {
  @override
  _AddinfoshopState createState() => _AddinfoshopState();
}

class _AddinfoshopState extends State<Addinfoshop> {
 
  String storename, address, phone, urlImage;
 
  File file;
    
@override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.greenAccent,
        title: Text('Add Infomation Shop'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Mystyle().mySizebox(),
            Mystyle().mySizebox(),
            Mystyle().showLogo4(),
            Mystyle().mySizebox(),
            Mystyle().showTitle('รายละเอียดร้าน'),
            Mystyle().mySizebox(),
            Mystyle().mySizebox(),           
            storeform(),
            Mystyle().mySizebox(),
            addressForm(),
            Mystyle().mySizebox(),
            phoneForm(),
            Mystyle().mySizebox(),
            groupImage(),
            Mystyle().mySizebox(),
            saveButton(),
          ],
        ),
      ),
    );
  }

  Widget saveButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton.icon(
        color: Mystyle().primaryColor,
        onPressed: () {
          if (
              storename == null ||
              storename.isEmpty ||
              address == null ||
              address.isEmpty ||
              phone == null ||
              phone.isEmpty) {
            normalDialog(context, 'กรุณากรอก ทุกช่อง คะ');
          } else if (file == null) {
            normalDialog(context, 'กรุณาเลือก รูปภาพ ด้วยคะ');
          } else {
            uploadImage();
          }
        },
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'Save Infomation',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'shop$i.jpg';
    print('nameImage = $nameImage, pathImage = ${file.path}');

   String url = '${MyConstant().domain}/GreenMarket1/saveShop.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value){
        print('Respone ===>>> $value');
        
        urlImage = '/GreenMarket1/shop/$nameImage';
        print('urlImage = $urlImage');
        editUserShop();
      });
    } catch (e) {}
  }

    Future<Null> editUserShop()async{

 SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');

    String url = '${MyConstant().domain}/GreenMarket1/editUserWhereId.php?isAdd=true&id=$id&name1=$storename&storename=$storename&address=$address&phone=$phone&phone=$phone&urlImage=$urlImage';

   await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่ ไม่สามารถ บันทึกได้ คะ');
      }
    });
  }

  Row groupImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_a_photo,
            size: 36.0,
          ),
          onPressed: () => chooseImage(ImageSource.camera),
        ),
        Container(
          width: 250.0,
          child: file == null 
              ? Image.asset('images/picture.png')
              : Image.file(file),
        ),
        IconButton(
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36.0,
          ),
          onPressed: () => chooseImage(ImageSource.gallery),
        )
      ],
    );
  }

 Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().getImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );

      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }
  
  

  Widget storeform() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => storename = value.trim(),
              decoration: InputDecoration(
                labelText: 'ชื่อร้านค้า',
                prefixIcon: Icon(Icons.store),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget addressForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => address = value.trim(),
              decoration: InputDecoration(
                labelText: 'ที่อยู่ร้านค้า :',
                prefixIcon: Icon(Icons.home),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget phoneForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => phone = value.trim(),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'เบอร์ติดต่อร้านค้า :',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}
