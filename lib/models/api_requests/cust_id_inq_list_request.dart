class CustIdToInqListRequest {
  String CustomerID;
  String CompanyID;

  CustIdToInqListRequest({this.CustomerID,this.CompanyID});

  CustIdToInqListRequest.fromJson(Map<String, dynamic> json) {
    CustomerID = json['CustomerID'];
    CompanyID = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerID'] = this.CustomerID;
    data['CompanyId'] = this.CompanyID;

    return data;
  }
}