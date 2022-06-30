/*
CompanyId:10032
InquiryNo:DEC21-003*/
class InquiryNoToDeleteProductRequest {
  String InquiryNo;
  String CompanyId;



  InquiryNoToDeleteProductRequest({this.InquiryNo,this.CompanyId});

  InquiryNoToDeleteProductRequest.fromJson(Map<String, dynamic> json) {
    InquiryNo = json['InquiryNo'];
    CompanyId = json['CompanyId'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InquiryNo'] = this.InquiryNo;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}