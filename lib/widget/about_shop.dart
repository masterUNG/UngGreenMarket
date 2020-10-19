import 'package:flutter/material.dart';
import 'package:greenmarket/model/user_model.dart';
import 'package:greenmarket/utility/my_constant.dart';
class AboutShop extends StatefulWidget {
  final UserModel userModel;
   AboutShop({Key key, this.userModel}) : super(key: key);
  @override
  _AboutShopState createState() => _AboutShopState();
}

class _AboutShopState extends State<AboutShop> {
UserModel userModel;
 double lat1, lng1, lat2, lng2, distance;
  String distanceString;
  int transport;
  //CameraPosition position;
  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;

  }


  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16.0),
                width: 150.0,
                height: 150.0,
                child: Image.network(
                  '${MyConstant().domain}${userModel.urlImage}',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(userModel.address),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(userModel.phone),
          ),
          ListTile(
            leading: Icon(Icons.directions_bike),
            title: Text(distance == null ? '' : '$distanceString กิโลเมตร'),
          ),
          ListTile(
            leading: Icon(Icons.transfer_within_a_station),
            title: Text(transport == null ? '' : '$transport บาท'),
          ),
      //    showmap(),
        ],
      ),
    );
  }
}