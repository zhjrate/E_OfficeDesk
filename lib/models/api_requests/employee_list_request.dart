class EmployeeListRequest {
  String CompanyId;
  String OrgCode;
  String LoginUserID;

  EmployeeListRequest({this.CompanyId,this.OrgCode,this.LoginUserID});

  EmployeeListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    OrgCode = json['OrgCode'];
    LoginUserID = json['LoginUserID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['OrgCode'] = this.OrgCode;
    data['LoginUserID'] = this.LoginUserID;

    return data;
  }
}