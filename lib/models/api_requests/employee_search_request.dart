class EmployeeSearchRequest {
  String CompanyId;
  String SearchKey;
  String LoginUserID;

  EmployeeSearchRequest({this.CompanyId,this.SearchKey,this.LoginUserID});

  EmployeeSearchRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    SearchKey = json['SearchKey'];
    LoginUserID = json['LoginUserID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['SearchKey'] = this.SearchKey;
    data['LoginUserID'] = this.LoginUserID;

    return data;
  }
}