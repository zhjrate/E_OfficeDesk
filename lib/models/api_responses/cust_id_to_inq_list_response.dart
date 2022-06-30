class CustIdToInqListResponse {
  List<InqNoDetails> details;
  int totalCount;

  CustIdToInqListResponse({this.details, this.totalCount});

  CustIdToInqListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new InqNoDetails.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class InqNoDetails {
  int customerID;
  String inquiryNo;

  InqNoDetails({this.customerID, this.inquiryNo});

  InqNoDetails.fromJson(Map<String, dynamic> json) {
    customerID = json['CustomerID'];
    inquiryNo = json['InquiryNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerID'] = this.customerID;
    data['InquiryNo'] = this.inquiryNo;
    return data;
  }
}