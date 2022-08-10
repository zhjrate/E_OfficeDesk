class SalesBillSearchByIdRequest {
  String CompanyId;

  String LoginUserID;

  SalesBillSearchByIdRequest({this.CompanyId, this.LoginUserID});

  SalesBillSearchByIdRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];

    LoginUserID = json['LoginUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;

    data['LoginUserID'] = this.LoginUserID;

    return data;
  }
}
