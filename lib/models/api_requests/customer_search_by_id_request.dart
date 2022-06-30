class CustomerSearchByIdRequest {
  int companyId;
  String loginUserID;
  String CustomerID;


  CustomerSearchByIdRequest({this.companyId, this.loginUserID,this.CustomerID});

  CustomerSearchByIdRequest.fromJson(Map<String, dynamic> json) {
    companyId = json['CompanyId'];
    loginUserID = json['LoginuserID'];
    CustomerID = json['CustomerId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.companyId;
    data['LoginuserID'] = this.loginUserID;
    data['CustomerId'] = this.CustomerID;

    return data;
  }
}