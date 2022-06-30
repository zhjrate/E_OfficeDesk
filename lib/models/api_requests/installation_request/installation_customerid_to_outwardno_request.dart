class InstallationCustomerIdToOutwardnoRequest {
  int CompanyId;
  String CustomerID;




  InstallationCustomerIdToOutwardnoRequest({this.CompanyId, this.CustomerID});

  InstallationCustomerIdToOutwardnoRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    CustomerID = json['CustomerID'];




  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['CustomerID'] = this.CustomerID;



    return data;
  }
}
