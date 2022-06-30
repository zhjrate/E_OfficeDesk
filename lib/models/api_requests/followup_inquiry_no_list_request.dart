class FollowerInquiryNoListRequest {
  String CompanyId;
  String LoginUserID;
  String CustomerID;
  String InquiryNo;
  String PageNo;
  String PageSize;

  FollowerInquiryNoListRequest({this.CompanyId,this.LoginUserID,this.CustomerID,this.InquiryNo,this.PageNo,this.PageSize});

  FollowerInquiryNoListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    CustomerID = json['CustomerID'];
    InquiryNo = json['InquiryNo'];
    PageNo = json['PageNo'];
    PageSize = json['PageSize'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
    data['CustomerID'] = this.CustomerID;
    data['InquiryNo'] = this.InquiryNo;
    data['PageNo'] = this.PageNo;
    data['PageSize'] = this.PageSize;


    return data;
  }
}