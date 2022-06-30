class CustomerIdToCustomerListRequest {
  String CompanyId;
  String CustomerID;
  String ListMode;


  CustomerIdToCustomerListRequest({this.CompanyId,this.CustomerID,this.ListMode});

  CustomerIdToCustomerListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    CustomerID = json['CustomerID'];
    ListMode = json['ListMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['CustomerID'] = this.CustomerID;
    data['ListMode'] = this.ListMode;

    return data;
  }
}