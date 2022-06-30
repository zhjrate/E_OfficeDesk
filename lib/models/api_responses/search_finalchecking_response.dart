class SearchFinalcheckingResponse {
  List<SearchFinalcheckingDetails> details;
  int totalCount;

  SearchFinalcheckingResponse({this.details, this.totalCount});

  SearchFinalcheckingResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SearchFinalcheckingDetails.fromJson(v));
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

class SearchFinalcheckingDetails {
  int rowNum;
  int pkID;
  int customerID;
  String customerName;
  int productID;
  String productName;
  String checkingDate;
  String checkingNo;
  String pCNo;

  SearchFinalcheckingDetails(
      {this.rowNum,
        this.pkID,
        this.customerID,
        this.customerName,
        this.productID,
        this.productName,
        this.checkingDate,
        this.checkingNo,
        this.pCNo});

  SearchFinalcheckingDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    customerID = json['CustomerID'];
    customerName = json['CustomerName'];
    productID = json['ProductID'];
    productName = json['ProductName'];
    checkingDate = json['CheckingDate'];
    checkingNo = json['CheckingNo'];
    pCNo = json['PCNo'];
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