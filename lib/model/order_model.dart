class OrderModel {
  String id;
  String orderDateTime;
  String idUser;
  String nameUser;
  String idShop;
  String nameShop;
  String idProduct;
  String nameProduct;
  String price;
  String amount;
  String sum;
  String status;

  OrderModel(
      {this.id,
      this.orderDateTime,
      this.idUser,
      this.nameUser,
      this.idShop,
      this.nameShop,
      this.idProduct,
      this.nameProduct,
      this.price,
      this.amount,
      this.sum,
      this.status});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDateTime = json['OrderDateTime'];
    idUser = json['idUser'];
    nameUser = json['NameUser'];
    idShop = json['idShop'];
    nameShop = json['NameShop'];
    idProduct = json['idProduct'];
    nameProduct = json['NameProduct'];
    price = json['Price'];
    amount = json['Amount'];
    sum = json['Sum'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['OrderDateTime'] = this.orderDateTime;
    data['idUser'] = this.idUser;
    data['NameUser'] = this.nameUser;
    data['idShop'] = this.idShop;
    data['NameShop'] = this.nameShop;
    data['idProduct'] = this.idProduct;
    data['NameProduct'] = this.nameProduct;
    data['Price'] = this.price;
    data['Amount'] = this.amount;
    data['Sum'] = this.sum;
    data['Status'] = this.status;
    return data;
  }
}

