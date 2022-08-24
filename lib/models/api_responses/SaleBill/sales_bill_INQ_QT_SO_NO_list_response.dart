class SalesBill_INQ_QT_SO_NO_ListResponse {
  List<SalesBill_INQ_QT_SO_NO_ListResponseDetails> details;
  int totalCount;

  SalesBill_INQ_QT_SO_NO_ListResponse({this.details, this.totalCount});

  SalesBill_INQ_QT_SO_NO_ListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SalesBill_INQ_QT_SO_NO_ListResponseDetails.fromJson(v));
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

class SalesBill_INQ_QT_SO_NO_ListResponseDetails {
  int customerID;
  String orderNo;

  SalesBill_INQ_QT_SO_NO_ListResponseDetails({this.customerID, this.orderNo});

  SalesBill_INQ_QT_SO_NO_ListResponseDetails.fromJson(
      Map<String, dynamic> json) {
    customerID = json['CustomerID'];
    orderNo = json['ModuleNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerID'] = this.customerID;
    data['ModuleNo'] = this.orderNo;
    return data;
  }
}
