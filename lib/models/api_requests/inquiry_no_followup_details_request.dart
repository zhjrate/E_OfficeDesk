/*
CompanyId:10032
InquiryNo:DEC21-003*/
class InquiryNoToFollowupDetailsRequest {
  String InquiryNo;
  String CompanyId;
  String CustomerID;



  InquiryNoToFollowupDetailsRequest({this.InquiryNo,this.CompanyId,this.CustomerID});

  InquiryNoToFollowupDetailsRequest.fromJson(Map<String, dynamic> json) {
    InquiryNo = json['InquiryNo'];
    CompanyId = json['CompanyId'];
    CustomerID = json['CustomerID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InquiryNo'] = this.InquiryNo;
    data['CompanyId'] = this.CompanyId;
    data['CustomerID'] = this.CustomerID;

    return data;
  }
}