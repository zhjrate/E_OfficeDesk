/*
CompanyId:10032
InquiryNo:DEC21-003*/
class InquiryNoToProductListRequest {
  String InquiryNo;
  String CompanyId;
  String LoginUserID;



  InquiryNoToProductListRequest({this.InquiryNo,this.CompanyId,this.LoginUserID});

  InquiryNoToProductListRequest.fromJson(Map<String, dynamic> json) {
    InquiryNo = json['InquiryNo'];
    CompanyId = json['CompanyId'];
    LoginUserID= json['LoginUserID'];



  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InquiryNo'] = this.InquiryNo;
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;

    return data;
  }
}