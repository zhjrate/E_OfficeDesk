class FinalCheckingListResponse {
  List<FinalCheckingListDetails> details;
  int totalCount;

  FinalCheckingListResponse({this.details, this.totalCount});

  FinalCheckingListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <FinalCheckingListDetails>[];
      json['details'].forEach((v) {
        details.add(new FinalCheckingListDetails.fromJson(v));
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

class FinalCheckingListDetails {
  int rowNum;
  int pkID;
  int customerID;
  String customerName;
  int productID;
  String productName;
  String checkingDate;
  String checkingNo;
  String pCNo;

  FinalCheckingListDetails(
      {this.rowNum,
        this.pkID,
        this.customerID,
        this.customerName,
        this.productID,
        this.productName,
        this.checkingDate,
        this.checkingNo,
        this.pCNo});

  FinalCheckingListDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    customerID = json['CustomerID']==null?0:json['CustomerID'];
    customerName = json['CustomerName']==null?"":json['CustomerName'];
    productID = json['ProductID']==null?0:json['ProductID'];
    productName = json['ProductName']==null?"":json['ProductName'];
    checkingDate = json['CheckingDate']==null?"":json['CheckingDate'];
    checkingNo = json['CheckingNo']==null?"":json['CheckingNo'];
    pCNo = json['PCNo']==null?"":json['PCNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['ProductID'] = this.productID;
    data['ProductName'] = this.productName;
    data['CheckingDate'] = this.checkingDate;
    data['CheckingNo'] = this.checkingNo;
    data['PCNo'] = this.pCNo;
    return data;
  }
}