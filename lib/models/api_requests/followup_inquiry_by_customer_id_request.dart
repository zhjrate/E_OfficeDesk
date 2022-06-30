class FollowerInquiryByCustomerIDRequest {
  String CompanyId;
  String CustomerID;


  FollowerInquiryByCustomerIDRequest({this.CompanyId,this.CustomerID});

  FollowerInquiryByCustomerIDRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    CustomerID = json['CustomerID'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['CustomerID'] = this.CustomerID;


    return data;
  }
}