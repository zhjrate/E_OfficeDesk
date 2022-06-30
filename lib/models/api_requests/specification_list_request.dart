/*LoginUserID:admin
QuotationNo:QT-JAN22-013
CompanyId:10032*/

class SpecificationListRequest {
  String LoginUserID;
  String QuotationNo;
  String CompanyId;

  SpecificationListRequest({this.LoginUserID,this.QuotationNo,this.CompanyId});

  SpecificationListRequest.fromJson(Map<String, dynamic> json) {
    LoginUserID = json['LoginUserID'];
    QuotationNo = json['QuotationNo'];
    CompanyId = json['CompanyId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginUserID'] = this.LoginUserID;
    data['QuotationNo'] = this.QuotationNo;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}