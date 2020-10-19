class ProductModel {
  String id;
  String idShop;
  String nameProduct;
  String pathImage;
  String price;
  String detail;
  String date;

  ProductModel(
      {this.id,
      this.idShop,
      this.nameProduct,
      this.pathImage,
      this.price,
      this.detail,
      this.date});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idShop = json['idShop'];
    nameProduct = json['NameProduct'];
    pathImage = json['PathImage'];
    price = json['Price'];
    detail = json['Detail'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idShop'] = this.idShop;
    data['NameProduct'] = this.nameProduct;
    data['PathImage'] = this.pathImage;
    data['Price'] = this.price;
    data['Detail'] = this.detail;
    data['Date'] = this.date;
    return data;
  }
}
