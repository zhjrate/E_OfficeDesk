class FollowupInquiryByCustomerIDResponse {
  List<FollowupInquiryDetails> details;
  int totalCount;

  FollowupInquiryByCustomerIDResponse({this.details, this.totalCount});

  FollowupInquiryByCustomerIDResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new FollowupInquiryDetails.fromJson(v));
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

class FollowupInquiryDetails {
  String inquiryNo;
  int inquiryStatusID;
  String inquiryStatus;
  String inquiryNoStatus;

  FollowupInquiryDetails(
      {this.inquiryNo,
        this.inquiryStatusID,
        this.inquiryStatus,
        this.inquiryNoStatus});

  FollowupInquiryDetails.fromJson(Map<String, dynamic> json) {
    inquiryNo = json['InquiryNo'];
    inquiryStatusID = json['InquiryStatusID'];
    inquiryStatus = json['InquiryStatus'];
    inquiryNoStatus = json['InquiryNoStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InquiryNo'] = this.inquiryNo;
    data['InquiryStatusID'] = this.inquiryStatusID;
    data['InquiryStatus'] = this.inquiryStatus;
    data['InquiryNoStatus'] = this.inquiryNoStatus;
    return data;
  }
}