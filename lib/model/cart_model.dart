class CartModel {
  int id;
  String idShop;
  String storename;
  String idProduct;
  String nameProduct;
  String price;
  String amount;
  String sum;

  CartModel(
      {this.id,
      this.idShop,
      this.storename,
      this.idProduct,
      this.nameProduct,
      this.price,
      this.amount,
      this.sum});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idShop = json['idShop'];
    storename = json['storename'];
    idProduct = json['idProduct'];
    nameProduct = json['nameProduct'];
    price = json['price'];
    amount = json['amount'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idShop'] = this.idShop;
    data['storename'] = this.storename;
    data['idProduct'] = this.idProduct;
    data['nameProduct'] = this.nameProduct;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['sum'] = this.sum;
    return data;
  }
}

