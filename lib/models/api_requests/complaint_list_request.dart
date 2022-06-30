class ComplaintListRequest {
  String LoginUserID;
  String CompanyId;

  ComplaintListRequest({this.LoginUserID,this.CompanyId});

  ComplaintListRequest.fromJson(Map<String, dynamic> json) {
    LoginUserID = json['LoginUserID'];
    CompanyId= json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;
    return data;
  }
}