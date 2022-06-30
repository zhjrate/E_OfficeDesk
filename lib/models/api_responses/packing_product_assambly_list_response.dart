class PackingProductAssamblyListResponse {
  List<PackingProductAssamblyDetails> details;
  int totalCount;

  PackingProductAssamblyListResponse({this.details, this.totalCount});

  PackingProductAssamblyListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new PackingProductAssamblyDetails.fromJson(v));
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

class PackingProductAssamblyDetails {
  int finishProductID;
  String finishProductName;
  int productGroupID;
  String productGroupName;
  int productID;
  String productName;
  String unit;
  double quantity;

  PackingProductAssamblyDetails(
      {this.finishProductID,
        this.finishProductName,
        this.productGroupID,
        this.productGroupName,
        this.productID,
        this.productName,
        this.unit,
        this.quantity});

  PackingProductAssamblyDetails.fromJson(Map<String, dynamic> json) {
    finishProductID = json['FinishProductID'];
    finishProductName = json['FinishProductName'];
    productGroupID = json['ProductGroupID'];
    productGroupName = json['ProductGroupName'];
    productID = json['ProductID'];
    productName = json['ProductName'];
    unit = json['Unit'];
    quantity = json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FinishProductID'] = this.finishProductID;
    data['FinishProductName'] = this.finishProductName;
    data['ProductGroupID'] = this.productGroupID;
    data['ProductGroupName'] = this.productGroupName;
    data['ProductID'] = this.productID;
    data['ProductName'] = this.productName;
    data['Unit'] = this.unit;
    data['Quantity'] = this.quantity;
    return data;
  }
}