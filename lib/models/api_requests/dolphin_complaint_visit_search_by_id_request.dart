class DolphinComplaintSearchByIDRequest {
  String LoginUserID;
  String CompanyId;

  DolphinComplaintSearchByIDRequest({this.LoginUserID,this.CompanyId});

  DolphinComplaintSearchByIDRequest.fromJson(Map<String, dynamic> json) {
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