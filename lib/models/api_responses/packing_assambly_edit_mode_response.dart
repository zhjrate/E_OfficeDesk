class PackingAssamblyEditModeResponse {
  List<PackingAssamblyEditModeResponseDetails> details;
  int totalCount;

  PackingAssamblyEditModeResponse({this.details, this.totalCount});

  PackingAssamblyEditModeResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new PackingAssamblyEditModeResponseDetails.fromJson(v));
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

class PackingAssamblyEditModeResponseDetails {
  int pkID;
  String pCNo;
  int finishProductID;
  String finishProductName;
  int productID;
  int productID1;
  String productName;
  int productGroupID;
  String productGroupName;
  double quantity;
  String unit;
  String productSpecification;
  String createdBy;
  String createdDate;
  String updatedDate;
  String updatedBy;

  PackingAssamblyEditModeResponseDetails(
      {this.pkID,
        this.pCNo,
        this.finishProductID,
        this.finishProductName,
        this.productID,
        this.productID1,
        this.productName,
        this.productGroupID,
        this.productGroupName,
        this.quantity,
        this.unit,
        this.productSpecification,
        this.createdBy,
        this.createdDate,
        this.updatedDate,
        this.updatedBy});

  PackingAssamblyEditModeResponseDetails.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID']==null?0:json['pkID'];
    pCNo = json['PCNo']==null?"":json['PCNo'];
    finishProductID = json['FinishProductID']==null?0:json['FinishProductID'];
    finishProductName = json['FinishProductName']==null?"":json['FinishProductName'];
    productID = json['ProductID']==null?0:json['ProductID'];
    productID1 = json['ProductID1']==null?0:json['ProductID1'];
    productName = json['ProductName']==null?"":json['ProductName'];
    productGroupID = json['ProductGroupID']==null?0:json['ProductGroupID'];
    productGroupName = json['ProductGroupName']==null?"":json['ProductGroupName'];
    quantity = json['Quantity']==null?0.00:json['Quantity'];
    unit = json['Unit']==null?"":json['Unit'];
    productSpecification = json['ProductSpecification']==null?"":json['ProductSpecification'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdDate = json['CreatedDate']==null?"":json['CreatedDate'];
    updatedDate = json['UpdatedDate']==null?"":json['UpdatedDate'];
    updatedBy = json['UpdatedBy']==null?"":json['UpdatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['PCNo'] = this.pCNo;
    data['FinishProductID'] = this.finishProductID;
    data['FinishProductName'] = this.finishProductName;
    data['ProductID'] = this.productID;
    data['ProductID1'] = this.productID1;
    data['ProductName'] = this.productName;
    data['ProductGroupID'] = this.productGroupID;
    data['ProductGroupName'] = this.productGroupName;
    data['Quantity'] = this.quantity;
    data['Unit'] = this.unit;
    data['ProductSpecification'] = this.productSpecification;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedDate'] = this.updatedDate;
    data['UpdatedBy'] = this.updatedBy;
    return data;
  }
}