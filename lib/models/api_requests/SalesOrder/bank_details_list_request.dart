/*CompanyId:4132
pkID:
LoginUserID:admin*/
class SaleOrderBankDetailsListRequest {
  String CompanyId;
  String pkID;
  String LoginUserID;

  SaleOrderBankDetailsListRequest(
      {this.CompanyId, this.LoginUserID, this.pkID});

  SaleOrderBankDetailsListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    pkID = json['pkID'];
    LoginUserID = json['LoginUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['pkID'] = this.pkID;
    data['LoginUserID'] = this.LoginUserID;

    return data;
  }
}
