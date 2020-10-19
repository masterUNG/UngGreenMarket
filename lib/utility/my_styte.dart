import 'package:flutter/material.dart';

class Mystyle {

  Color darkColor = Colors.blue.shade900;
  Color primaryColor = Color(0xFF90DEA1);

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }


  TextStyle mainTitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.purple,
  );

  TextStyle mainH2Title = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.greenAccent,
  );

  BoxDecoration myBoxDecoration(String namePic) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/$namePic'),
        fit: BoxFit.cover,
      ),
    );
  }


  SizedBox mySizebox() => SizedBox(
    width: 8.0,
    height: 16.0,
    );

Widget titleCenter(BuildContext context, String string) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Text(
          string,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );


Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.bold,
        ),
      );

Text showTitleH3(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blue.shade900,
          fontWeight: FontWeight.w500,
        ),
      );

      Text showTitleH3White(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      );

      Text showTitleH3Red(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red.shade900,
          fontWeight: FontWeight.w500,
        ),
      );

      Text showTitleH3Purple(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.purple.shade700,
          fontWeight: FontWeight.w500,
        ),
      );

  Container showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/vegetable.png'),
    );
  }
  Container showLogo1() {
    return Container(
      width: 120.0,
      child: Image.asset('images/dis.png'),
    );
  }
  Container showLogo2() {
    return Container(
      width: 120.0,
      child: Image.asset('images/admin.png'),
    );
  }
    Container showLogo3() {
    return Container(
      width: 120.0,
      child: Image.asset('images/3.png'),
    );
  }
 Container showLogo4() {
    return Container(
      width: 120.0,
      child: Image.asset('images/store.png'),
    );
  }
  Mystyle();

  iconShowCart(BuildContext context) {}
}
