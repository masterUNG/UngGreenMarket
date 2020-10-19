import 'package:greenmarket/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'greenmaket.db';
  final String tableDatabase = 'Ordertable';
  int version = 1;

  final String idColumn = 'id';
  final String idShopColumn = 'idShop';
  final String storename = 'storename ';
  final String idProduct = 'idProduct ';
  final String nameProduct = 'nameProduct';
  final String price = 'price';
  final String amount = 'amount';
  final String sum = 'sum';

  SQLiteHelper() {
    initDatabase();
  }
  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $idShopColumn TEXT, $storename TEXT, $idProduct TEXT, $nameProduct TEXT, $price TEXT, $amount TEXT, $sum TEXT)'),
        version: version);
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<Null> insertDataToSQLite(CartModel cartModel) async {
    print(
        'at insertData idProduct ==================>>>>>>> ${cartModel.idProduct}');
    Database database = await connectedDatabase();
    try {
      database.insert(
        tableDatabase,
        cartModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }

  Future<List<CartModel>> readAllDataFromSQLite() async {
    Database database = await connectedDatabase();
    List<CartModel> cartModels = List();

    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    for (var map in maps) {
      CartModel cartModel = CartModel.fromJson(map);
      cartModels.add(cartModel);
    }

    return cartModels;
  }

  Future<Null> deleteDataWhereId(int id) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase, where: '$idColumn = $id');
    } catch (e) {
      print('e delete ==> ${e.toString()}');
    }
  }

  Future<Null> deleteAllData() async {
    Database database = await connectedDatabase();
    try {
      await database.delete(tableDatabase);
    } catch (e) {
      print('e delete All ==>> ${e.toString()}');
    }
  }
}
