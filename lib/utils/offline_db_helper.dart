import 'dart:async';

import 'package:path/path.dart';
import 'package:soleoserp/models/common/contact_model.dart';
import 'package:soleoserp/models/common/final_checking_items.dart';
import 'package:soleoserp/models/common/inquiry_product_model.dart';
import 'package:soleoserp/models/common/other_charge_table.dart';
import 'package:soleoserp/models/common/packingProductAssamblyTable.dart';
import 'package:soleoserp/models/common/quotationtable.dart';
import 'package:soleoserp/models/common/sale_bill_other_charge_table.dart';
import 'package:soleoserp/models/common/sales_bill_table.dart';
import 'package:soleoserp/models/common/sales_order_table.dart';
import 'package:soleoserp/models/common/so_other_charge_table.dart';
import 'package:sqflite/sqflite.dart';

class OfflineDbHelper {
  static OfflineDbHelper _offlineDbHelper;
  static Database database;

  static const TABLE_CONTACTS = "contacts";
  static const TABLE_INQUIRY_PRODUCT = "inquiry_product";
  static const TABLE_QUOTATION_PRODUCT = "quotation_product";
  static const TABLE_SALES_ORDER_PRODUCT = "sales_order_product";
  static const TABLE_SALES_BILL_PRODUCT = "sales_bill_product";

  static const TABLE_QUOTATION_OTHERCHARGE_TABLE = "quotation_other_charge";
  static const TABLE_PACKING_PRODUCT_ASSAMBLY_TABLE =
      "packing_product_assambly_table";
  static const TABLE_FINAL_CHECKING_ITEM_TABLE = "final_checking_table";
  static const TABLE_SALES_ORDER_OTHERCHARGE_TABLE = "sales_order_other_charge";
  static const TABLE_SALES_BILL_OTHERCHARGE_TABLE = "sales_bill_other_charge";

/*  static createInstance() async {
    _offlineDbHelper = OfflineDbHelper();
    database = await openDatabase(
      join(await getDatabasesPath(), 'soleoserp_database.db'),
      onCreate: (db, version) {
        return db.execute(


          'CREATE TABLE $TABLE_CONTACTS(id INTEGER PRIMARY KEY AUTOINCREMENT, pkId TEXT,CustomerID TEXT, ContactDesignationName TEXT, ContactDesigCode1 TEXT, CompanyId TEXT, ContactPerson1 TEXT, ContactNumber1 TEXT, ContactEmail1 TEXT, LoginUserID TEXT)',
         // 'CREATE TABLE $TABLE_INQUIRY_PRODUCT(id INTEGER PRIMARY KEY AUTOINCREMENT, InquiryNo TEXT,LoginUserID TEXT, CompanyId TEXT, ProductName TEXT, ProductID TEXT, Quantity TEXT, UnitPrice TEXT)',

        );

      },
      version: 2,
    );
  }*/

  static createInstance() async {
    _offlineDbHelper = OfflineDbHelper();
    database = await openDatabase(
        join(await getDatabasesPath(), 'soleoserp_database.db'),
        onCreate: (db, version) => _createDb(db),
        version: 6);
  }

  static void _createDb(Database db) {
    db.execute(
      'CREATE TABLE $TABLE_CONTACTS(id INTEGER PRIMARY KEY AUTOINCREMENT, pkId TEXT,CustomerID TEXT, ContactDesignationName TEXT, ContactDesigCode1 TEXT, CompanyId TEXT, ContactPerson1 TEXT, ContactNumber1 TEXT, ContactEmail1 TEXT, LoginUserID TEXT)',
    );
    db.execute(
      'CREATE TABLE $TABLE_INQUIRY_PRODUCT(id INTEGER PRIMARY KEY AUTOINCREMENT, InquiryNo TEXT,LoginUserID TEXT, CompanyId TEXT, ProductName TEXT, ProductID TEXT, Quantity TEXT, UnitPrice TEXT,TotalAmount TEXT)',
    );
    db.execute(
      'CREATE TABLE $TABLE_QUOTATION_PRODUCT(id INTEGER PRIMARY KEY AUTOINCREMENT, QuotationNo TEXT, ProductSpecification TEXT , ProductID INTEGER, ProductName TEXT, Unit TEXT, Quantity DOUBLE, UnitRate DOUBLE, DiscountPercent DOUBLE, DiscountAmt DOUBLE ,NetRate DOUBLE, Amount DOUBLE, TaxRate DOUBLE, TaxAmount DOUBLE, NetAmount DOUBLE, TaxType INTEGER, CGSTPer DOUBLE, SGSTPer DOUBLE, IGSTPer DOUBLE, CGSTAmt DOUBLE, SGSTAmt DOUBLE, IGSTAmt DOUBLE, StateCode INTEGER, pkID INTEGER, LoginUserID TEXT, CompanyId TEXT , BundleId INTEGER ,HeaderDiscAmt DOUBLE)',
    );
    db.execute(
      'CREATE TABLE $TABLE_QUOTATION_OTHERCHARGE_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT,Headerdiscount DOUBLE,Tot_BasicAmt DOUBLE,OtherChargeWithTaxamt DOUBLE,Tot_GstAmt DOUBLE,OtherChargeExcludeTaxamt DOUBLE,Tot_NetAmount DOUBLE,ChargeID1 INTEGER,ChargeAmt1 DOUBLE,ChargeBasicAmt1 DOUBLE,ChargeGSTAmt1 DOUBLE,ChargeID2 INTEGER,ChargeAmt2 DOUBLE,ChargeBasicAmt2 DOUBLE,ChargeGSTAmt2 DOUBLE,ChargeID3 INTEGER,ChargeAmt3 DOUBLE,ChargeBasicAmt3 DOUBLE,ChargeGSTAmt3 DOUBLE,ChargeID4 INTEGER,ChargeAmt4 DOUBLE,ChargeBasicAmt4 DOUBLE,ChargeGSTAmt4 DOUBLE,ChargeID5 INTEGER,ChargeAmt5 DOUBLE,ChargeBasicAmt5 DOUBLE,ChargeGSTAmt5 DOUBLE)',
    );
    db.execute(
      'CREATE TABLE $TABLE_PACKING_PRODUCT_ASSAMBLY_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT,PCNo TEXT,FinishProductID INTEGER,FinishProductName TEXT,ProductGroupID INTEGER,ProductGroupName TEXT,ProductID INTEGER,ProductName TEXT,Unit TEXT,Quantity DOUBLE,ProductSpecification TEXT,Remarks TEXT,LoginUserID TEXT,CompanyId TEXT)',
    );
    db.execute(
      'CREATE TABLE $TABLE_FINAL_CHECKING_ITEM_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT,CheckingNo TEXT,CustomerID TEXT,Item TEXT,Checked TEXT,Remarks TEXT,SerialNo TEXT,SRno TEXT,LoginUserID TEXT,CompanyId TEXT)',
    );
    db.execute(
      'CREATE TABLE $TABLE_SALES_ORDER_PRODUCT(id INTEGER PRIMARY KEY AUTOINCREMENT, SalesOrderNo TEXT, ProductSpecification TEXT , ProductID INTEGER, ProductName TEXT, Unit TEXT, Quantity DOUBLE, UnitRate DOUBLE, DiscountPercent DOUBLE, DiscountAmt DOUBLE ,NetRate DOUBLE, Amount DOUBLE, TaxRate DOUBLE, TaxAmount DOUBLE, NetAmount DOUBLE, TaxType INTEGER, CGSTPer DOUBLE, SGSTPer DOUBLE, IGSTPer DOUBLE, CGSTAmt DOUBLE, SGSTAmt DOUBLE, IGSTAmt DOUBLE, StateCode INTEGER, pkID INTEGER, LoginUserID TEXT, CompanyId TEXT , BundleId INTEGER ,HeaderDiscAmt DOUBLE,DeliveryDate TEXT)',
    );
    db.execute(
      'CREATE TABLE $TABLE_SALES_ORDER_OTHERCHARGE_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT,Headerdiscount DOUBLE,Tot_BasicAmt DOUBLE,OtherChargeWithTaxamt DOUBLE,Tot_GstAmt DOUBLE,OtherChargeExcludeTaxamt DOUBLE,Tot_NetAmount DOUBLE,ChargeID1 INTEGER,ChargeAmt1 DOUBLE,ChargeBasicAmt1 DOUBLE,ChargeGSTAmt1 DOUBLE,ChargeID2 INTEGER,ChargeAmt2 DOUBLE,ChargeBasicAmt2 DOUBLE,ChargeGSTAmt2 DOUBLE,ChargeID3 INTEGER,ChargeAmt3 DOUBLE,ChargeBasicAmt3 DOUBLE,ChargeGSTAmt3 DOUBLE,ChargeID4 INTEGER,ChargeAmt4 DOUBLE,ChargeBasicAmt4 DOUBLE,ChargeGSTAmt4 DOUBLE,ChargeID5 INTEGER,ChargeAmt5 DOUBLE,ChargeBasicAmt5 DOUBLE,ChargeGSTAmt5 DOUBLE)',
    );
    db.execute(
      'CREATE TABLE $TABLE_SALES_BILL_PRODUCT(id INTEGER PRIMARY KEY AUTOINCREMENT, QuotationNo TEXT, ProductSpecification TEXT , ProductID INTEGER, ProductName TEXT, Unit TEXT, Quantity DOUBLE, UnitRate DOUBLE, DiscountPercent DOUBLE, DiscountAmt DOUBLE ,NetRate DOUBLE, Amount DOUBLE, TaxRate DOUBLE, TaxAmount DOUBLE, NetAmount DOUBLE, TaxType INTEGER, CGSTPer DOUBLE, SGSTPer DOUBLE, IGSTPer DOUBLE, CGSTAmt DOUBLE, SGSTAmt DOUBLE, IGSTAmt DOUBLE, StateCode INTEGER, pkID INTEGER, LoginUserID TEXT, CompanyId TEXT , BundleId INTEGER ,HeaderDiscAmt DOUBLE)',
    );
    db.execute(
      'CREATE TABLE $TABLE_SALES_BILL_OTHERCHARGE_TABLE(id INTEGER PRIMARY KEY AUTOINCREMENT,Headerdiscount DOUBLE,Tot_BasicAmt DOUBLE,OtherChargeWithTaxamt DOUBLE,Tot_GstAmt DOUBLE,OtherChargeExcludeTaxamt DOUBLE,Tot_NetAmount DOUBLE,ChargeID1 INTEGER,ChargeAmt1 DOUBLE,ChargeBasicAmt1 DOUBLE,ChargeGSTAmt1 DOUBLE,ChargeID2 INTEGER,ChargeAmt2 DOUBLE,ChargeBasicAmt2 DOUBLE,ChargeGSTAmt2 DOUBLE,ChargeID3 INTEGER,ChargeAmt3 DOUBLE,ChargeBasicAmt3 DOUBLE,ChargeGSTAmt3 DOUBLE,ChargeID4 INTEGER,ChargeAmt4 DOUBLE,ChargeBasicAmt4 DOUBLE,ChargeGSTAmt4 DOUBLE,ChargeID5 INTEGER,ChargeAmt5 DOUBLE,ChargeBasicAmt5 DOUBLE,ChargeGSTAmt5 DOUBLE)',
    );
  }

  static OfflineDbHelper getInstance() {
    return _offlineDbHelper;
  }

  ///Here Customer Contact Table Implimentation

  Future<int> insertContact(ContactModel model) async {
    final db = await database;

    return await db.insert(
      TABLE_CONTACTS,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ContactModel>> getContacts() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(TABLE_CONTACTS);

    return List.generate(maps.length, (i) {
      return ContactModel(
        maps[i]['pkId'],
        maps[i]['CustomerID'],
        maps[i]['ContactDesignationName'],
        maps[i]['ContactDesigCode1'],
        maps[i]['CompanyId'],
        maps[i]['ContactPerson1'],
        maps[i]['ContactNumber1'],
        maps[i]['ContactEmail1'],
        maps[i]['LoginUserID'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateContact(ContactModel model) async {
    final db = await database;

    await db.update(
      TABLE_CONTACTS,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteContact(int id) async {
    final db = await database;

    await db.delete(
      TABLE_CONTACTS,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteContactTable() async {
    final db = await database;

    await db.delete(TABLE_CONTACTS);
  }

  ///Here InquiryProduct Table Implimentation

  Future<int> insertInquiryProduct(InquiryProductModel model) async {
    final db = await database;

    return await db.insert(
      TABLE_INQUIRY_PRODUCT,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<InquiryProductModel>> getInquiryProduct() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_INQUIRY_PRODUCT);

    return List.generate(maps.length, (i) {
      return InquiryProductModel(
        maps[i]['InquiryNo'],
        maps[i]['LoginUserID'],
        maps[i]['CompanyId'],
        maps[i]['ProductName'],
        maps[i]['ProductID'],
        maps[i]['Quantity'],
        maps[i]['UnitPrice'],
        maps[i]['TotalAmount'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateInquiryProduct(InquiryProductModel model) async {
    final db = await database;

    await db.update(
      TABLE_INQUIRY_PRODUCT,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteInquiryProduct(int id) async {
    final db = await database;

    await db.delete(
      TABLE_INQUIRY_PRODUCT,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteALLInquiryProduct() async {
    final db = await database;

    await db.delete(TABLE_INQUIRY_PRODUCT);
  }

  ///Here QuotationProduct Table Implimentation

  Future<int> insertQuotationProduct(QuotationTable model) async {
    final db = await database;

    return await db.insert(
      TABLE_QUOTATION_PRODUCT,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<QuotationTable>> getQuotationProduct() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_QUOTATION_PRODUCT);

    return List.generate(maps.length, (i) {
/*  int ProductID;
  String ProductName;
  String Unit;
  double Quantity;
  double UnitRate;
  double Disc;
  double NetRate;
  double Amount;
  double TaxPer;
  double TaxAmount;
  double NetAmount;
  bool IsTaxType;
*/
      return QuotationTable(
        maps[i]['QuotationNo'],
        maps[i]['ProductSpecification'],
        maps[i]['ProductID'],
        maps[i]['ProductName'],
        maps[i]['Unit'],
        maps[i]['Quantity'],
        maps[i]['UnitRate'],
        maps[i]['DiscountPercent'],
        maps[i]['DiscountAmt'],
        maps[i]['NetRate'],
        maps[i]['Amount'],
        maps[i]['TaxRate'],
        maps[i]['TaxAmount'],
        maps[i]['NetAmount'],
        maps[i]['TaxType'],
        maps[i]['CGSTPer'],
        maps[i]['SGSTPer'],
        maps[i]['IGSTPer'],
        maps[i]['CGSTAmt'],
        maps[i]['SGSTAmt'],
        maps[i]['IGSTAmt'],
        maps[i]['StateCode'],
        maps[i]['pkID'],
        maps[i]['LoginUserID'],
        maps[i]['CompanyId'],
        maps[i]['BundleId'],
        maps[i]['HeaderDiscAmt'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateQuotationProduct(QuotationTable model) async {
    final db = await database;

    await db.update(
      TABLE_QUOTATION_PRODUCT,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteQuotationProduct(int id) async {
    final db = await database;

    await db.delete(
      TABLE_QUOTATION_PRODUCT,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteALLQuotationProduct() async {
    final db = await database;

    await db.delete(TABLE_QUOTATION_PRODUCT);
  }

  ///Here Quotation OtherCharge Table Implimentation

  Future<int> insertQuotationOtherCharge(QT_OtherChargeTable model) async {
    final db = await database;

    return await db.insert(
      TABLE_QUOTATION_OTHERCHARGE_TABLE,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<QT_OtherChargeTable>> getQuotationOtherCharge() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_QUOTATION_OTHERCHARGE_TABLE);

    return List.generate(maps.length, (i) {
      return QT_OtherChargeTable(
          maps[i]['Headerdiscount'],
          maps[i]['Tot_BasicAmt'],
          maps[i]['OtherChargeWithTaxamt'],
          maps[i]['Tot_GstAmt'],
          maps[i]['OtherChargeExcludeTaxamt'],
          maps[i]['Tot_NetAmount'],
          maps[i]['ChargeID1'],
          maps[i]['ChargeAmt1'],
          maps[i]['ChargeBasicAmt1'],
          maps[i]['ChargeGSTAmt1'],
          maps[i]['ChargeID2'],
          maps[i]['ChargeAmt2'],
          maps[i]['ChargeBasicAmt2'],
          maps[i]['ChargeGSTAmt2'],
          maps[i]['ChargeID3'],
          maps[i]['ChargeAmt3'],
          maps[i]['ChargeBasicAmt3'],
          maps[i]['ChargeGSTAmt3'],
          maps[i]['ChargeID4'],
          maps[i]['ChargeAmt4'],
          maps[i]['ChargeBasicAmt4'],
          maps[i]['ChargeGSTAmt4'],
          maps[i]['ChargeID5'],
          maps[i]['ChargeAmt5'],
          maps[i]['ChargeBasicAmt5'],
          maps[i]['ChargeGSTAmt5'],
          id: maps[i]['id']);
    });
  }

  Future<void> updateQuotationOtherCharge(QT_OtherChargeTable model) async {
    final db = await database;

    await db.update(
      TABLE_QUOTATION_OTHERCHARGE_TABLE,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteQuotationOtherCharge(int id) async {
    final db = await database;

    await db.delete(
      TABLE_QUOTATION_OTHERCHARGE_TABLE,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteALLQuotationOtherCharge() async {
    final db = await database;

    await db.delete(TABLE_QUOTATION_OTHERCHARGE_TABLE);
  }

  ///Here SalesBillProduct Table Implimentation

  Future<int> insertSalesBillProduct(SaleBillTable model) async {
    final db = await database;

    return await db.insert(
      TABLE_SALES_BILL_PRODUCT,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SaleBillTable>> getSalesBillProduct() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_SALES_BILL_PRODUCT);

    return List.generate(maps.length, (i) {
      return SaleBillTable(
        maps[i]['QuotationNo'],
        maps[i]['ProductSpecification'],
        maps[i]['ProductID'],
        maps[i]['ProductName'],
        maps[i]['Unit'],
        maps[i]['Quantity'],
        maps[i]['UnitRate'],
        maps[i]['DiscountPercent'],
        maps[i]['DiscountAmt'],
        maps[i]['NetRate'],
        maps[i]['Amount'],
        maps[i]['TaxRate'],
        maps[i]['TaxAmount'],
        maps[i]['NetAmount'],
        maps[i]['TaxType'],
        maps[i]['CGSTPer'],
        maps[i]['SGSTPer'],
        maps[i]['IGSTPer'],
        maps[i]['CGSTAmt'],
        maps[i]['SGSTAmt'],
        maps[i]['IGSTAmt'],
        maps[i]['StateCode'],
        maps[i]['pkID'],
        maps[i]['LoginUserID'],
        maps[i]['CompanyId'],
        maps[i]['BundleId'],
        maps[i]['HeaderDiscAmt'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateSalesBillProduct(SaleBillTable model) async {
    final db = await database;

    await db.update(
      TABLE_SALES_BILL_PRODUCT,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteSalesBillProduct(int id) async {
    final db = await database;

    await db.delete(
      TABLE_SALES_BILL_PRODUCT,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteALLSalesBillProduct() async {
    final db = await database;

    await db.delete(TABLE_SALES_BILL_PRODUCT);
  }

  ///Here SaleBill OtherCharge Table Implimentation

  Future<int> insertSalesBillOtherCharge(
      SaleBill_OtherChargeTable model) async {
    final db = await database;

    return await db.insert(
      TABLE_SALES_BILL_OTHERCHARGE_TABLE,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SaleBill_OtherChargeTable>> getSalesBillOtherCharge() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_SALES_BILL_OTHERCHARGE_TABLE);

    return List.generate(maps.length, (i) {
      return SaleBill_OtherChargeTable(
          maps[i]['Headerdiscount'],
          maps[i]['Tot_BasicAmt'],
          maps[i]['OtherChargeWithTaxamt'],
          maps[i]['Tot_GstAmt'],
          maps[i]['OtherChargeExcludeTaxamt'],
          maps[i]['Tot_NetAmount'],
          maps[i]['ChargeID1'],
          maps[i]['ChargeAmt1'],
          maps[i]['ChargeBasicAmt1'],
          maps[i]['ChargeGSTAmt1'],
          maps[i]['ChargeID2'],
          maps[i]['ChargeAmt2'],
          maps[i]['ChargeBasicAmt2'],
          maps[i]['ChargeGSTAmt2'],
          maps[i]['ChargeID3'],
          maps[i]['ChargeAmt3'],
          maps[i]['ChargeBasicAmt3'],
          maps[i]['ChargeGSTAmt3'],
          maps[i]['ChargeID4'],
          maps[i]['ChargeAmt4'],
          maps[i]['ChargeBasicAmt4'],
          maps[i]['ChargeGSTAmt4'],
          maps[i]['ChargeID5'],
          maps[i]['ChargeAmt5'],
          maps[i]['ChargeBasicAmt5'],
          maps[i]['ChargeGSTAmt5'],
          id: maps[i]['id']);
    });
  }

  Future<void> updateSaleBillOtherCharge(
      SaleBill_OtherChargeTable model) async {
    final db = await database;

    await db.update(
      TABLE_SALES_BILL_OTHERCHARGE_TABLE,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteSaleBillOtherCharge(int id) async {
    final db = await database;

    await db.delete(
      TABLE_SALES_BILL_OTHERCHARGE_TABLE,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteALLSaleBillOtherCharge() async {
    final db = await database;

    await db.delete(TABLE_SALES_BILL_OTHERCHARGE_TABLE);
  }

  ///Here SalesORder Product Table Implimentation

  Future<int> insertSalesOrderProduct(SalesOrderTable model) async {
    final db = await database;

    return await db.insert(
      TABLE_SALES_ORDER_PRODUCT,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SalesOrderTable>> getSalesOrderProduct() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_SALES_ORDER_PRODUCT);

    return List.generate(maps.length, (i) {
      return SalesOrderTable(
        maps[i]['SalesOrderNo'],
        maps[i]['ProductSpecification'],
        maps[i]['ProductID'],
        maps[i]['ProductName'],
        maps[i]['Unit'],
        maps[i]['Quantity'],
        maps[i]['UnitRate'],
        maps[i]['DiscountPercent'],
        maps[i]['DiscountAmt'],
        maps[i]['NetRate'],
        maps[i]['Amount'],
        maps[i]['TaxRate'],
        maps[i]['TaxAmount'],
        maps[i]['NetAmount'],
        maps[i]['TaxType'],
        maps[i]['CGSTPer'],
        maps[i]['SGSTPer'],
        maps[i]['IGSTPer'],
        maps[i]['CGSTAmt'],
        maps[i]['SGSTAmt'],
        maps[i]['IGSTAmt'],
        maps[i]['StateCode'],
        maps[i]['pkID'],
        maps[i]['LoginUserID'],
        maps[i]['CompanyId'],
        maps[i]['BundleId'],
        maps[i]['HeaderDiscAmt'],
        maps[i]['DeliveryDate'],
        id: maps[i]['id'],
      );
    });
  }

  Future<void> updateSalesOrderProduct(SalesOrderTable model) async {
    final db = await database;

    await db.update(
      TABLE_SALES_ORDER_PRODUCT,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteSalesOrderProduct(int id) async {
    final db = await database;

    await db.delete(
      TABLE_SALES_ORDER_PRODUCT,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteALLSalesOrderProduct() async {
    final db = await database;

    await db.delete(TABLE_SALES_ORDER_PRODUCT);
  }

  ///Here SalesOrder OtherCharge Table Implimentation

  Future<int> insertSalesOrderOtherCharge(SO_OtherChargeTable model) async {
    final db = await database;

    return await db.insert(
      TABLE_SALES_ORDER_OTHERCHARGE_TABLE,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SO_OtherChargeTable>> getSalesOrderOtherCharge() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_SALES_ORDER_OTHERCHARGE_TABLE);

    return List.generate(maps.length, (i) {
      return SO_OtherChargeTable(
          maps[i]['Headerdiscount'],
          maps[i]['Tot_BasicAmt'],
          maps[i]['OtherChargeWithTaxamt'],
          maps[i]['Tot_GstAmt'],
          maps[i]['OtherChargeExcludeTaxamt'],
          maps[i]['Tot_NetAmount'],
          maps[i]['ChargeID1'],
          maps[i]['ChargeAmt1'],
          maps[i]['ChargeBasicAmt1'],
          maps[i]['ChargeGSTAmt1'],
          maps[i]['ChargeID2'],
          maps[i]['ChargeAmt2'],
          maps[i]['ChargeBasicAmt2'],
          maps[i]['ChargeGSTAmt2'],
          maps[i]['ChargeID3'],
          maps[i]['ChargeAmt3'],
          maps[i]['ChargeBasicAmt3'],
          maps[i]['ChargeGSTAmt3'],
          maps[i]['ChargeID4'],
          maps[i]['ChargeAmt4'],
          maps[i]['ChargeBasicAmt4'],
          maps[i]['ChargeGSTAmt4'],
          maps[i]['ChargeID5'],
          maps[i]['ChargeAmt5'],
          maps[i]['ChargeBasicAmt5'],
          maps[i]['ChargeGSTAmt5'],
          id: maps[i]['id']);
    });
  }

  Future<void> updateSalesOrderOtherCharge(SO_OtherChargeTable model) async {
    final db = await database;

    await db.update(
      TABLE_SALES_ORDER_OTHERCHARGE_TABLE,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteSalesOrderOtherCharge(int id) async {
    final db = await database;

    await db.delete(
      TABLE_SALES_ORDER_OTHERCHARGE_TABLE,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteALLSalesOrderOtherCharge() async {
    final db = await database;

    await db.delete(TABLE_SALES_ORDER_OTHERCHARGE_TABLE);
  }

  /// Here Packing Product Assambly List Implimentation

  Future<int> insertPackingProductAssambly(
      PackingProductAssamblyTable model) async {
    final db = await database;

    return await db.insert(
      TABLE_PACKING_PRODUCT_ASSAMBLY_TABLE,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<PackingProductAssamblyTable>> getPackingProductAssambly() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_PACKING_PRODUCT_ASSAMBLY_TABLE);

    return List.generate(maps.length, (i) {
      /* int id;
  String PCNo;
  int FinishProductID;
  String FinishProductName;
  int ProductGroupID;
  String ProductGroupName;
  int ProductID;
  String ProductName;
  String Unit;
  double Quantity;
  String ProductSpecification;
  String Remarks;
  String LoginUserID;
  String CompanyId;*/
      return PackingProductAssamblyTable(
          maps[i]['PCNo'],
          maps[i]['FinishProductID'],
          maps[i]['FinishProductName'],
          maps[i]['ProductGroupID'],
          maps[i]['ProductGroupName'],
          maps[i]['ProductID'],
          maps[i]['ProductName'],
          maps[i]['Unit'],
          maps[i]['Quantity'],
          maps[i]['ProductSpecification'],
          maps[i]['Remarks'],
          maps[i]['LoginUserID'],
          maps[i]['CompanyId'],
          id: maps[i]['id']);
    });
  }

  Future<void> updatePackingProductAssambly(
      PackingProductAssamblyTable model) async {
    final db = await database;

    await db.update(
      TABLE_PACKING_PRODUCT_ASSAMBLY_TABLE,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deletePackingProductAssambly(int id) async {
    final db = await database;

    await db.delete(
      TABLE_PACKING_PRODUCT_ASSAMBLY_TABLE,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteALLPackingProductAssambly() async {
    final db = await database;

    await db.delete(TABLE_PACKING_PRODUCT_ASSAMBLY_TABLE);
  }

  /// Here Final Checking Items List Implimentaion

  Future<int> insertFinalCheckingItems(FinalCheckingItems model) async {
    final db = await database;

    return await db.insert(
      TABLE_FINAL_CHECKING_ITEM_TABLE,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FinalCheckingItems>> getFinalCheckingItems() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_FINAL_CHECKING_ITEM_TABLE);

    return List.generate(maps.length, (i) {
      /*String CheckingNo;
  String CustomerID;
  String Item;
  String Checked;
  String Remarks;
  String SerialNo;
  String SRno;
  String LoginUserID;
  String CompanyId;*/
      return FinalCheckingItems(
          maps[i]['CheckingNo'],
          maps[i]['CustomerID'],
          maps[i]['Item'],
          maps[i]['Checked'],
          maps[i]['Remarks'],
          maps[i]['SerialNo'],
          maps[i]['SRno'],
          maps[i]['LoginUserID'],
          maps[i]['CompanyId'],
          id: maps[i]['id']);
    });
  }

  Future<void> updateFinalCheckingItems(FinalCheckingItems model) async {
    final db = await database;

    await db.update(
      TABLE_FINAL_CHECKING_ITEM_TABLE,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<void> deleteFinalCheckingItems(int id) async {
    final db = await database;

    await db.delete(
      TABLE_FINAL_CHECKING_ITEM_TABLE,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteALLFinalCheckingItems() async {
    final db = await database;

    await db.delete(TABLE_FINAL_CHECKING_ITEM_TABLE);
  }
}
