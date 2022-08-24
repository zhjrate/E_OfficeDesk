class MaterialOutwardListRequest {
  String LoginUserID;
  String SearchKey;
  int CompanyId;

  MaterialOutwardListRequest(
      {this.LoginUserID, this.SearchKey, this.CompanyId});

  MaterialOutwardListRequest.fromJson(Map<String, dynamic> json) {
    LoginUserID = json['LoginUserID'];
    SearchKey = json['SearchKey'];
    CompanyId = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginUserID'] = this.LoginUserID;
    data['SearchKey'] = this.SearchKey;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}
