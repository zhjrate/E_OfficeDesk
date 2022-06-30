class InqNoToLoadProductListRequest {
  String CompanyId;
  String InquiryNo;
  String LoginUserID;

  InqNoToLoadProductListRequest({this.CompanyId,this.InquiryNo,this.LoginUserID});

  InqNoToLoadProductListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    InquiryNo = json['InquiryNo'];
    LoginUserID = json['LoginUserID'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['InquiryNo'] = this.InquiryNo;
    data['LoginUserID'] = this.LoginUserID;


    return data;
  }
}