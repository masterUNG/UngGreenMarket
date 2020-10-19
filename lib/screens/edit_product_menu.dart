import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:greenmarket/model/product_model.dart';
import 'package:greenmarket/utility/my_constant.dart';
import 'package:greenmarket/utility/normal_dialog.dart';
import 'package:image_picker/image_picker.dart';

class EditProductMenu extends StatefulWidget {

   final ProductModel productModel;
EditProductMenu({Key key, this.productModel}) : super(key: key);


  @override
  _EditProductMenuState createState() => _EditProductMenuState();
}

class _EditProductMenuState extends State<EditProductMenu> {
ProductModel productModel;
  File file;
  String name, price, detail, pathImage;


  @override
  void initState() {
    super.initState();
    productModel = widget.productModel;
    name = productModel.nameProduct;
    price = productModel.price;
    detail = productModel.detail;
    pathImage = productModel.pathImage;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: uploadButton(),
      appBar: AppBar( backgroundColor: Colors.greenAccent,
        title: Text('ปรับปรุง สินค้าเกษตร ${productModel.nameProduct}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            nameProduct(),
            groupImage(),
            priceProduct(),
            detailProduct(),
               ],
        ),
      ),
    );
  }

  FloatingActionButton uploadButton() {
    return FloatingActionButton(
      onPressed: () {
        if (name.isEmpty || price.isEmpty || detail.isEmpty) {
          normalDialog(context, 'กรุณากรอกให้ครบ ทุกช่องคะ');
        } else {
          confirmEdit();
        }
      },
      child: Icon(Icons.cloud_upload),
    );
  }

  Future<Null> confirmEdit() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการจะ เปลี่ยนแปลง สินค้าเกษตร ใช่ไหมค่ะ ?'),
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  editValueOnMySQL();
                },
                icon: Icon(Icons.check, color: Colors.blueAccent,),
                label: Text('เปลี่ยนแปลง'),
              ),
              FlatButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.clear, color: Colors.red,),
                label: Text('ไม่เปลี่ยนแปลง'),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Null> editValueOnMySQL() async {

    String id = productModel.id;
    String url = '${MyConstant().domain}/GreenMarket1/editProductWhereId.php?isAdd=true&id=$id&nameProduct=$name&pathImage=$pathImage&price=$price&detail=$detail';
   await Dio().get(url).then((value) {

      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่ มีอะไร ? ผิดพลาด');
      }
    });
  }
  Widget groupImage() => Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => chooseImage(ImageSource.camera),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            width: 250.0,
            height: 250,
            child: file == null
                ? Image.network(
                    '${MyConstant().domain}${productModel.pathImage}',
                    fit: BoxFit.cover,
                  )
                : Image.file(file),
          ),
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () => chooseImage(ImageSource.gallery),
          ),
        ],
      );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Widget nameProduct() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => name = value.trim(),
              initialValue: name,
              decoration: InputDecoration(
                labelText: 'ชื่อ เมนู สินค้าเกษตร',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget priceProduct() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => price = value.trim(),
              keyboardType: TextInputType.number,
              initialValue: price,
              decoration: InputDecoration(
                labelText: 'ราคา สินค้า',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );

  Widget detailProduct() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            width: 250.0,
            child: TextFormField(
              onChanged: (value) => detail = value.trim(),
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              initialValue: detail,
              decoration: InputDecoration(
                labelText: 'รายละเอียด สินค้า',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      );
}