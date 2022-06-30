class PackingNoListResponse {
  List<PackingNoListResponseDetails> details;
  int totalCount;

  PackingNoListResponse({this.details, this.totalCount});

  PackingNoListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new PackingNoListResponseDetails.fromJson(v));
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

class PackingNoListResponseDetails {
  int customerID;
  String customerName;
  String pCNo;

  PackingNoListResponseDetails({this.customerID, this.customerName, this.pCNo});

  PackingNoListResponseDetails.fromJson(Map<String, dynamic> json) {
    customerID = json['CustomerID'];
    customerName = json['CustomerName'];
    pCNo = json['PCNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerID'] = this.customerID;
    data['CustomerName'] = this.customerName;
    data['PCNo'] = this.pCNo;
    return data;
  }
}