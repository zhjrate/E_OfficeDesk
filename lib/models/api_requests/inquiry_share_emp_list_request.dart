class InquiryShareEmpListRequest {
  String InquiryNo;
  String CompanyId;


  InquiryShareEmpListRequest({this.InquiryNo,this.CompanyId});

  InquiryShareEmpListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    InquiryNo = json['InquiryNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['InquiryNo'] = this.InquiryNo;

    return data;
  }
}