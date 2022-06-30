class InqNoToProductListResponse {
  List<InqNoToProductDetails> details;
  int totalCount;

  InqNoToProductListResponse({this.details, this.totalCount});

  InqNoToProductListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new InqNoToProductDetails.fromJson(v));
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

class InqNoToProductDetails {
  int pkID;
  String inquiryNo;
  int productID;
  String productName;
  String productNameLong;
  String productSpecification;
  String unit;
  double unitPrice;
  double taxRate;
  int taxType;
  double quantity;

  InqNoToProductDetails(
      {this.pkID,
        this.inquiryNo,
        this.productID,
        this.productName,
        this.productNameLong,
        this.productSpecification,
        this.unit,
        this.unitPrice,
        this.taxRate,
        this.taxType,
        this.quantity});

  InqNoToProductDetails.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID']==null?0:json['pkID'];
    inquiryNo = json['InquiryNo']==null?"":json['InquiryNo'];
    productID = json['ProductID']==null?0:json['ProductID'];
    productName = json['ProductName']==null?"":json['ProductName'];
    productNameLong = json['ProductNameLong']==null?"":json['ProductNameLong'];
    productSpecification = json['ProductSpecification']==null?"":json['ProductSpecification'];
    unit = json['Unit']==null?"":json['Unit'];
    unitPrice = json['UnitPrice']==null?0.00:json['UnitPrice'];
    taxRate = json['TaxRate']==null?0.00:json['TaxRate'];
    taxType = json['TaxType']==null?0.00:json['TaxType'];
    quantity = json['Quantity']==null?0.00:json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['InquiryNo'] = this.inquiryNo;
    data['ProductID'] = this.productID;
    data['ProductName'] = this.productName;
    data['ProductNameLong'] = this.productNameLong;
    data['ProductSpecification'] = this.productSpecification;
    data['Unit'] = this.unit;
    data['UnitPrice'] = this.unitPrice;
    data['TaxRate'] = this.taxRate;
    data['TaxType'] = this.taxType;
    data['Quantity'] = this.quantity;
    return data;
  }
}