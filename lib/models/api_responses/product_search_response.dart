class ProductSearchResponse {
  List<Details> details;
  int totalCount;

  ProductSearchResponse({this.details, this.totalCount});

  ProductSearchResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class Details {
  int rowNum;
  int pkID;
  String productName;
  String productNameLong;
  String productAlias;
  String productType;
  String unit;
  double unitPrice;
  int taxRate;
  int addTaxPer;
  String productAdvantage;
  String productApplication;
  int productGroupID;
  String productGroupName;
  String productImage;
  int brandID;
  String brandName;
  int taxType;
  bool activeFlag;
  String activeFlagDesc;
  String hSNCode;
  double manPower;
  double horsePower;
  double minUnitPrice;
  double maxUnitPrice;
  double profitRatio;
  double minQuantity;
  double unitQuantity;
  String unitSize;
  String unitSurface;
  String unitGrade;
  double boxWeight;
  double boxSQFT;
  double boxSQMT;
  double openingSTK;
  double inwardSTK;
  double outwardSTK;
  double closingSTK;

  Details(
      {this.rowNum,
        this.pkID,
        this.productName,
        this.productNameLong,
        this.productAlias,
        this.productType,
        this.unit,
        this.unitPrice,
        this.taxRate,
        this.addTaxPer,
        this.productAdvantage,
        this.productApplication,
        this.productGroupID,
        this.productGroupName,
        this.productImage,
        this.brandID,
        this.brandName,
        this.taxType,
        this.activeFlag,
        this.activeFlagDesc,
        this.hSNCode,
        this.manPower,
        this.horsePower,
        this.minUnitPrice,
        this.maxUnitPrice,
        this.profitRatio,
        this.minQuantity,
        this.unitQuantity,
        this.unitSize,
        this.unitSurface,
        this.unitGrade,
        this.boxWeight,
        this.boxSQFT,
        this.boxSQMT,
        this.openingSTK,
        this.inwardSTK,
        this.outwardSTK,
        this.closingSTK});

  Details.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    productName = json['ProductName'];
    productNameLong = json['ProductNameLong'];
    productAlias = json['ProductAlias'];
    productType = json['ProductType'];
    unit = json['Unit'];
    unitPrice = json['UnitPrice'];
    taxRate = json['TaxRate'];
    addTaxPer = json['AddTaxPer'];
    productAdvantage = json['ProductAdvantage'];
    productApplication = json['ProductApplication'];
    productGroupID = json['ProductGroupID'];
    productGroupName = json['ProductGroupName'];
    productImage = json['ProductImage'];
    brandID = json['BrandID'];
    brandName = json['BrandName'];
    taxType = json['TaxType'];
    activeFlag = json['ActiveFlag'];
    activeFlagDesc = json['ActiveFlagDesc'];
    hSNCode = json['HSNCode'];
    manPower = json['ManPower'];
    horsePower = json['HorsePower'];
    minUnitPrice = json['Min_UnitPrice'];
    maxUnitPrice = json['Max_UnitPrice'];
    profitRatio = json['ProfitRatio'];
    minQuantity = json['MinQuantity'];
    unitQuantity = json['UnitQuantity'];
    unitSize = json['UnitSize'];
    unitSurface = json['UnitSurface'];
    unitGrade = json['UnitGrade'];
    boxWeight = json['Box_Weight'];
    boxSQFT = json['Box_SQFT'];
    boxSQMT = json['Box_SQMT'];
    openingSTK = json['OpeningSTK'];
    inwardSTK = json['InwardSTK'];
    outwardSTK = json['OutwardSTK'];
    closingSTK = json['ClosingSTK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['ProductName'] = this.productName;
    data['ProductNameLong'] = this.productNameLong;
    data['ProductAlias'] = this.productAlias;
    data['ProductType'] = this.productType;
    data['Unit'] = this.unit;
    data['UnitPrice'] = this.unitPrice;
    data['TaxRate'] = this.taxRate;
    data['AddTaxPer'] = this.addTaxPer;
    data['ProductAdvantage'] = this.productAdvantage;
    data['ProductApplication'] = this.productApplication;
    data['ProductGroupID'] = this.productGroupID;
    data['ProductGroupName'] = this.productGroupName;
    data['ProductImage'] = this.productImage;
    data['BrandID'] = this.brandID;
    data['BrandName'] = this.brandName;
    data['TaxType'] = this.taxType;
    data['ActiveFlag'] = this.activeFlag;
    data['ActiveFlagDesc'] = this.activeFlagDesc;
    data['HSNCode'] = this.hSNCode;
    data['ManPower'] = this.manPower;
    data['HorsePower'] = this.horsePower;
    data['Min_UnitPrice'] = this.minUnitPrice;
    data['Max_UnitPrice'] = this.maxUnitPrice;
    data['ProfitRatio'] = this.profitRatio;
    data['MinQuantity'] = this.minQuantity;
    data['UnitQuantity'] = this.unitQuantity;
    data['UnitSize'] = this.unitSize;
    data['UnitSurface'] = this.unitSurface;
    data['UnitGrade'] = this.unitGrade;
    data['Box_Weight'] = this.boxWeight;
    data['Box_SQFT'] = this.boxSQFT;
    data['Box_SQMT'] = this.boxSQMT;
    data['OpeningSTK'] = this.openingSTK;
    data['InwardSTK'] = this.inwardSTK;
    data['OutwardSTK'] = this.outwardSTK;
    data['ClosingSTK'] = this.closingSTK;
    return data;
  }
}