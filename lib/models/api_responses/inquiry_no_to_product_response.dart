class InquiryNoToProductResponse {
  List<InquiryProductDetails> details;
  int totalCount;

  InquiryNoToProductResponse({this.details, this.totalCount});

  InquiryNoToProductResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new InquiryProductDetails.fromJson(v));
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

class InquiryProductDetails {
  int rowNum;
  int pkID;
  String inquiryNo;
  double unitPrice;
  double taxRate;
  String unit;
  int productID;
  String productName;
  double quantity;
  String productNameLong;
  String productAlias;
  int taxType;
  double minRate;
  double maxRate;

  InquiryProductDetails(
      {this.rowNum,
        this.pkID,
        this.inquiryNo,
        this.unitPrice,
        this.taxRate,
        this.unit,
        this.productID,
        this.productName,
        this.quantity,
        this.productNameLong,
        this.productAlias,
        this.taxType,
        this.minRate,
        this.maxRate});

  InquiryProductDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    inquiryNo = json['InquiryNo'];
    unitPrice = json['UnitPrice'];
    taxRate = json['TaxRate'];
    unit = json['Unit'];
    productID = json['ProductID'];
    productName = json['ProductName'];
    quantity = json['Quantity'];
    productNameLong = json['ProductNameLong'];
    productAlias = json['ProductAlias'];
    taxType = json['TaxType'];
    minRate = json['MinRate'];
    maxRate = json['MaxRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['InquiryNo'] = this.inquiryNo;
    data['UnitPrice'] = this.unitPrice;
    data['TaxRate'] = this.taxRate;
    data['Unit'] = this.unit;
    data['ProductID'] = this.productID;
    data['ProductName'] = this.productName;
    data['Quantity'] = this.quantity;
    data['ProductNameLong'] = this.productNameLong;
    data['ProductAlias'] = this.productAlias;
    data['TaxType'] = this.taxType;
    data['MinRate'] = this.minRate;
    data['MaxRate'] = this.maxRate;
    return data;
  }
}