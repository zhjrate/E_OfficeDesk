class BankDropDownRequest {
  String CompanyID;
  String LoginUserID;
  String pkID;

  BankDropDownRequest({this.CompanyID,this.LoginUserID,this.pkID});

  BankDropDownRequest.fromJson(Map<String, dynamic> json) {
    CompanyID = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    pkID = json['pkID'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyID;
    data['LoginUserID'] = this.LoginUserID;
    data['pkID'] = this.pkID;

    return data;
  }
}