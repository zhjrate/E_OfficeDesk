class SalesOrderPDFGenerateRequest {
  String CompanyId;
  String OrderNo;

  SalesOrderPDFGenerateRequest({this.CompanyId,this.OrderNo});

  SalesOrderPDFGenerateRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    OrderNo = json['OrderNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['OrderNo'] = this.OrderNo;

    return data;
  }
}