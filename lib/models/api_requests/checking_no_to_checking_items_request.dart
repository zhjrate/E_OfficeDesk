class CheckingNoToCheckingItemsRequest {
  String CheckingNo;
  String CompanyId;
  String LoginUserID;

  /*LoginUserID:admin
CompanyId:11051
CheckingNo:FC-MAR22-003*/
  CheckingNoToCheckingItemsRequest({this.CheckingNo,this.CompanyId,this.LoginUserID});

  CheckingNoToCheckingItemsRequest.fromJson(Map<String, dynamic> json) {
    CheckingNo = json['CheckingNo'];
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CheckingNo'] = this.CheckingNo;
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;

    return data;
  }
}