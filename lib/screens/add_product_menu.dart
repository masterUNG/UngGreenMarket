import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/my_styte.dart';
import 'package:greenmarket/utility/normal_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductMenu extends StatefulWidget {
  @override
  _AddProductMenuState createState() => _AddProductMenuState();
}

class _AddProductMenuState extends State<AddProductMenu> {

File file;
 String  nameProduct, price, detail;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.greenAccent,
        title: Text('เพิ่มเมนูสินค้าเกษตร'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            showTitleProduct('รูปสินค้าเกษตร'),
            groupImage(),
            showTitleProduct('รายละเอียดสินค้าเกษตร'),
            nameForm(),
            Mystyle().mySizebox(),
            priceForm(),
            Mystyle().mySizebox(),
            detailForm(),
             Mystyle().mySizebox(),
            saveButton()
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
          if (file == null) {
            normalDialog(context,
                'กรุณาเลือกรูปภาพ สินค้า โดยการ Tap Camera หรือ Gallery');
          } else if (nameProduct == null ||
              nameProduct.isEmpty ||
              price == null ||
              price.isEmpty ||
              detail == null ||
              detail.isEmpty) {
            normalDialog(context, 'กรุณากรอก ทุกช่อง คะ');
          } else {
           uploadProductAndInsertData();
          }
        },
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'Save Product Menu',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<Null> uploadProductAndInsertData() async {
    String urlUpload = '${MyConstant().domain}/GreenMarket1/saveProduct.php';

    Random random = Random();
    int i = random.nextInt(1000000);
    String nameFile = 'product$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);
      FormData formData = FormData.fromMap(map);

      await Dio().post(urlUpload, data: formData).then((value) async {
        String urlPathImage = '/GreenMarket1/Product/$nameFile';
        print('urlPathImage = ${MyConstant().domain}$urlPathImage');

        SharedPreferences preferences = await SharedPreferences.getInstance();
        String idShop = preferences.getString('id');

        String urlInsertData =
            '${MyConstant().domain}/GreenMarket1/addProduct.php?isAdd=true&idShop=$idShop&NameProduct=$nameProduct&PathImage=$urlPathImage&Price=$price&Detail=$detail';
        await Dio().get(urlInsertData).then((value) => Navigator.pop(context));
      });
    } catch (e) {}
  }

  Widget nameForm() => Container(
        width: 250.0,
        child: TextField(onChanged: (value) => nameProduct = value.trim(),
          decoration: InputDecoration(prefixIcon: Icon(Icons.restaurant),
            labelText: 'ชื่อสินค้า',
            border: OutlineInputBorder()
          ),
        ),
      );

      Widget priceForm() => Container(
        width: 250.0,
        child: TextField(keyboardType: TextInputType.number,
          onChanged: (value) => price = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.attach_money),
            labelText: 'ราคาสินค้า',
            border: OutlineInputBorder()
          ),
        ),
      );


      Widget detailForm() => Container(
        width: 250.0,
        child: TextField(onChanged: (value) => detail = value.trim(),
          keyboardType: TextInputType.multiline,maxLines: 3,
          decoration: InputDecoration(  prefixIcon: Icon(Icons.details),
            labelText: 'รายละเอียดสินค้า',
            border: OutlineInputBorder()
          ),
        ),
      );

  Row groupImage() {
    return Row(
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
          ? Image.asset('images/vegeta.png')
          : Image.file(file),
        ),
        IconButton(
          icon: Icon(Icons.add_photo_alternate), 
          onPressed:() => chooseImage(ImageSource.gallery),
        ),
      ],
    );
  }


 Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker() .getImage(
        source: source, 
        maxWidth: 800.0, 
        maxHeight: 800.0
        );
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
}

  Widget showTitleProduct(String string) {
   return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Mystyle().showTitleH2(string),
        ],
      ),
    );
  }
}