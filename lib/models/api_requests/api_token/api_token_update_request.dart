class APITokenUpdateRequest {
  String UserID;
  String CompanyId;
  String TokenNo;

  APITokenUpdateRequest({this.UserID, this.CompanyId,this.TokenNo});

  APITokenUpdateRequest.fromJson(Map<String, dynamic> json) {
    UserID = json['UserID'];
    CompanyId = json['CompanyId'];
    TokenNo = json['TokenNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserID'] = this.UserID;
    data['CompanyId'] = this.CompanyId;
    data['TokenNo']= this.TokenNo;
    return data;
  }
}
