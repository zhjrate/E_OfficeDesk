class FollowupHistoryListRequest {
  String CompanyId;
  String InquiryNo;
  String CustomerID;

  FollowupHistoryListRequest({this.CompanyId,this.InquiryNo,this.CustomerID});

  FollowupHistoryListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    InquiryNo = json['InquiryNo'];
    CustomerID = json['CustomerID'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['InquiryNo'] = this.InquiryNo;
    data['CustomerID'] = this.CustomerID;




    return data;
  }
}