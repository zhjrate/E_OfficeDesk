class InquiryStatusListResponse {
  List<Details> details;
  int totalCount;

  InquiryStatusListResponse({this.details, this.totalCount});

  InquiryStatusListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
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

class Details {
  int rowNum;
  int pkID;
  String inquiryStatus;
  String statusCategory;

  Details({this.rowNum, this.pkID, this.inquiryStatus, this.statusCategory});

  Details.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    inquiryStatus = json['InquiryStatus'];
    statusCategory = json['StatusCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['InquiryStatus'] = this.inquiryStatus;
    data['StatusCategory'] = this.statusCategory;
    return data;
  }
}