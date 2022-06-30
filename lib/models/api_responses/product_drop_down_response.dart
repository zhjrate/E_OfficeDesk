class ProductDropDownResponse {
  List<ProductDropDownDetails> details;
  int totalCount;

  ProductDropDownResponse({this.details, this.totalCount});

  ProductDropDownResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new ProductDropDownDetails.fromJson(v));
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

class ProductDropDownDetails {
  int pkID;
  String productName;
  String unit;

  ProductDropDownDetails({this.pkID, this.productName, this.unit});

  ProductDropDownDetails.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    productName = json['ProductName'];
    unit = json['Unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['ProductName'] = this.productName;
    data['Unit'] = this.unit;
    return data;
  }
}