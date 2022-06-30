class SalaryUpadListRequest {
  String CompanyId;
  String LoginUserID;
  String pkID;

  SalaryUpadListRequest({this.CompanyId,this.LoginUserID,this.pkID});

  SalaryUpadListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    pkID = json['pkID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
    data['pkID'] = this.pkID;

    return data;
  }
}