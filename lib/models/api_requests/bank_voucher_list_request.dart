class BankVoucherListRequest {
  String LoginUserID;
  String CompanyID;
  BankVoucherListRequest({this.LoginUserID,this.CompanyID});

  BankVoucherListRequest.fromJson(Map<String, dynamic> json) {
    LoginUserID = json['LoginUserID'];
    CompanyID = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyID;


    return data;
  }
}